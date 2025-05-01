# {{ cookiecutter.project_short_description }} - {{ cookiecutter.base_model }}

This directory conducts federated instruction tuning with a pretrained [{{ cookiecutter.base_model }}](https://huggingface.co/{{ cookiecutter.base_model }}) model on a [Medical dataset](https://huggingface.co/datasets/flwrlabs/medical-meadow-medical-flashcards).

We use [Flower Datasets](https://flower.dev/docs/datasets/) to download, partition and preprocess the dataset.

[Flower](https://flower.ai/)'s Simulation Engine is used to simulate the LLM fine-tuning process in federated way,
which allows users to perform the training on a single GPU.


## Methodology

This baseline performs federated LLM fine-tuning with {% if cookiecutter.peft_use_dora is sameas "true" %}[DoRA](https://arxiv.org/abs/2402.09353){% else %}[LoRA](https://arxiv.org/abs/2106.09685){% endif %} using the [🤗PEFT](https://huggingface.co/docs/peft/en/index) library.
The clients' models are aggregated with `FedAvg` strategy.
This provides a baseline performance for the leaderboard of Medical challenge.

### {{ cookiecutter.base_model }}

For the **{{ cookiecutter.base_model }}** model we adopted the following fine-tuning methodology:

- **Precision**: `{% if cookiecutter.bf16 is sameas "true" %}bf16{% else %}fp16{% endif %}` for model weights.
- **Quantization**: `{{ cookiecutter.quantization }}-bit` quantization for reduced memory usage.
- **Optimizer**: `{{ cookiecutter.optimizer }}`
- **{% if cookiecutter.peft_use_dora is sameas "true" %}[DoRA](https://arxiv.org/abs/2402.09353){% else %}[LoRA](https://arxiv.org/abs/2106.09685){% endif %} Configuration**:
  - Rank (r): `{{ cookiecutter.peft_lora_r }}`
  - Alpha: `{{ cookiecutter.peft_lora_alpha }}`
  - Target Modules:
    - `down_proj`,
    - `gate_up_proj`,
    - `o_proj`,
    - `qkv_proj`,
- **Training Configuration**:
  - Batch size: `{{ cookiecutter.per_device_train_batch_size }}`
  - Maximum number of steps: `{{ cookiecutter.max_steps }}`
  - Accumulation steps: `{{ cookiecutter.accumulation_steps }}`
  - Total number of rounds: `{{ cookiecutter.num_server_rounds }}`
  - Fraction fit per round: `{{ cookiecutter.fraction_fit }}`
- **Learning Rate Scheduler**:
  - Cosine Annealing over rounds, where:
    - Maximum LR: `{{ cookiecutter.min_lr }}`
    - Minimum LR: `{{ cookiecutter.max_lr }}`
  - Constant learning rate scheduler over steps
- **Strategy**: `FedAvg`

## Environments setup

Project dependencies are defined in `pyproject.toml`. Install them in an activated Python environment with:

```shell
python -m pip install --upgrade pip wheel setuptools packaging

pip install -e .
pip install flash-attn --no-build-isolation   # Install FlashAttention-2
```

## Experimental setup

The dataset is divided into 10 partitions in an IID fashion, a partition is assigned to each ClientApp.
We randomly sample a fraction ({{ cookiecutter.fraction_fit }}) of the total nodes to participate in each round, for a total of `{{ cookiecutter.num_server_rounds }}` rounds.
All settings are defined in `pyproject.toml`.

> [!IMPORTANT]
> Please note that `[tool.flwr.app.config.static]` and `options.num-supernodes` under `[tool.flwr.federations.local-simulation]` are not allowed to be modified for fair competition if you plan to participated in the [LLM leaderboard](https://flower.ai/benchmarks/llm-leaderboard).


## Running the challenge

Run the challenge with default config values.
The configs are defined in `[tool.flwr.app.config]` entry of `pyproject.toml`, and are loaded automatically.

```bash
flwr run
```

## Running the evaluation

To evaluate the fine-tuned LLM adapter, please check the following link:

-  [Evaluation for Medical challenge](https://github.com/adap/flower/tree/main/benchmarks/flowertune-llm/evaluation/medical)

## Model saving

The global PEFT model checkpoints are saved every 5 rounds after aggregation on the sever side as default, which can be specified with `train.save-every-round` under [tool.flwr.app.config] entry in `pyproject.toml`.
