"""flowertune-code: A Flower / FlowerTune app."""

import torch
from tqdm import tqdm

from io import BytesIO
from logging import INFO, WARN
from typing import List, Tuple, Union, Optional, Dict

from flwr.common import FitIns, FitRes, Parameters, log, parameters_to_ndarrays, Scalar, ndarrays_to_parameters
from flwr.server.client_manager import ClientManager
from flwr.server.client_proxy import ClientProxy
from flwr.server.strategy import FedAvg
from flwr.server.strategy.aggregate import aggregate


class FlowerTuneLlm(FedAvg):
    """Customised FedAvg strategy implementation.

    This class behaves just like FedAvg but also tracks the communication
    costs associated with `fit` over FL rounds.
    """

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.comm_tracker = CommunicationTracker()

    def configure_fit(
        self, server_round: int, parameters: Parameters, client_manager: ClientManager
    ):
        """Configure the next round of training."""
        return_clients = super().configure_fit(server_round, parameters, client_manager)

        # Test communication costs
        fit_ins_list = [fit_ins for _, fit_ins in return_clients]
        self.comm_tracker.track(fit_ins_list)

        return return_clients

    def aggregate_fit(
        self,
        server_round: int,
        results: List[Tuple[ClientProxy, FitRes]],
        failures: List[Union[Tuple[ClientProxy, FitRes], BaseException]],
    ):
        """Aggregate fit results using weighted average."""
        # Test communication costs
        fit_res_list = [fit_res for _, fit_res in results]
        self.comm_tracker.track(fit_res_list)

        parameters_aggregated, metrics_aggregated = super().aggregate_fit(
            server_round, results, failures
        )

        return parameters_aggregated, metrics_aggregated


class FlowerTuneLlmFlexLoRA(FedAvg):
    """Customised FlexLoRA strategy implementation.

    Federated Fine-tuning of Large Language Models under Heterogeneous Tasks and Client Resources"
    https://arxiv.org/abs/2402.11505

    This class behaves just like FlexLoRA but also tracks the communication
    costs associated with `fit` over FL rounds.
    """

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.comm_tracker = CommunicationTracker()

    def configure_fit(
            self, server_round: int, parameters: Parameters, client_manager: ClientManager
    ):
        """Configure the next round of training."""
        return_clients = super().configure_fit(server_round, parameters, client_manager)

        # Test communication costs
        fit_ins_list = [fit_ins for _, fit_ins in return_clients]
        self.comm_tracker.track(fit_ins_list)

        return return_clients

    def distribute_weight_fast(self, svd_weights, max_rank):
        u, s, v = torch.svd(torch.tensor(svd_weights, device='cuda'))
        U = u[:, :max_rank]
        S = s[:max_rank]
        V = v.T[:max_rank, :]
        lora_B = U @ torch.diag(S)
        lora_A = V
        # merge_rate = 2
        merge_rate = max_rank / max_rank
        return lora_A, (lora_B / merge_rate)

    def aggregate_fit(
            self,
            server_round: int,
            results: List[Tuple[ClientProxy, FitRes]],
            failures: List[Union[Tuple[ClientProxy, FitRes], BaseException]],
    ) -> Tuple[Optional[Parameters], Dict[str, Scalar]]:
        """Aggregate fit results using weighted average."""
        # Test communication costs
        fit_res_list = [fit_res for _, fit_res in results]
        self.comm_tracker.track(fit_res_list)

        # FlexLoRA
        print('use FlexLoRA for Aggregation')
        fit_res_params = []
        for _, fit_res in results:
            LoRA_A_list = []
            LoRA_B_list = []
            bis_list = []
            params = parameters_to_ndarrays(fit_res.parameters)  # a list
            for p in params:
                if len(p.shape) == 2:
                    rank = min(p.shape[0], p.shape[1])
                    if p.shape[0] <= 200:
                        LoRA_A_list.append(p)
                    elif p.shape[1] <= 200:
                        LoRA_B_list.append(p)
                    else:
                        raise Exception("doesn't support other ranks")
                elif len(p.shape) == 1:
                    bis_list.append(p)
                else:
                    raise Exception("doesn't support other than 1, 2 dimensions")

            mul_params = []
            if len(bis_list) == 0:
                for A_weights, B_weights in zip(LoRA_A_list, LoRA_B_list):
                    W = torch.matmul(torch.tensor(B_weights, device='cuda'), torch.tensor(A_weights, device='cuda'))
                    mul_params.append(W.detach().cpu().numpy())
                fit_res_params.append(mul_params)
            else:
                for A_weights, B_weights, bis in zip(LoRA_A_list, LoRA_B_list, bis_list):
                    mul_params.append(torch.matmul(torch.Tensor(B_weights), torch.Tensor(A_weights)).numpy())
                    mul_params.append(bis)
                fit_res_params.append(mul_params)

        weights_results = [
            (p, fit_res.num_examples)
            for (_, fit_res), p in zip(results, fit_res_params)
        ]
        weights_results_ = aggregate(weights_results)

        new_LoRA_weights = []
        print('Check weight result lenth')
        print(len(weights_results_))
        for agg_w in tqdm(weights_results_):
            if len(agg_w.shape) == 2:
                new_A, new_B = self.distribute_weight_fast(agg_w, max_rank=rank)
                new_LoRA_weights.append(new_A.detach().cpu())
                new_LoRA_weights.append(new_B.detach().cpu())
            elif len(agg_w.shape) == 1:
                new_LoRA_weights.append(agg_w)
            else:
                raise Exception('something wrong')

        # parameters_aggregated = ndarrays_to_parameters(weights_results_)
        parameters_aggregated = ndarrays_to_parameters(new_LoRA_weights)

        del new_LoRA_weights
        torch.cuda.empty_cache()

        metrics_aggregated = {}
        return parameters_aggregated, metrics_aggregated


class CommunicationTracker:
    """Communication costs tracker over FL rounds."""

    def __init__(self):
        self.curr_comm_cost = 0.0

    @staticmethod
    def _compute_bytes(parameters):
        return sum([BytesIO(t).getbuffer().nbytes for t in parameters.tensors])

    def track(self, fit_list: List[Union[FitIns, FitRes]]):
        size_bytes_list = [
            self._compute_bytes(fit_ele.parameters) for fit_ele in fit_list
        ]
        comm_cost = sum(size_bytes_list) / 1024**2

        self.curr_comm_cost += comm_cost
        log(
            INFO,
            "Communication budget: used %.2f MB (+%.2f MB this round) / 200,000 MB",
            self.curr_comm_cost,
            comm_cost,
        )

        if self.curr_comm_cost > 2e5:
            log(
                WARN,
                "The accumulated communication cost has exceeded 200,000 MB. "
                "Please consider reducing it if you plan to participate "
                "FlowerTune LLM Leaderboard.",
            )
