# FlowerTune-LLM-Labs - Fine-tuned LLMs

The following fine-tuned LLMs are sent to the [FlowerTune LLM Leaderboard](https://flower.ai/benchmarks/llm-leaderboard/).

The goal is to evaluate LLMs on different domains of tasks, experiment with different fine-tuning techniques, and compare their performances across various domains.

---

## FlowerTune LLM - Coding

| Model                                | Adapter                                  | Average Pass@1 | HumanEval Pass@1 | MBPP Pass@1 | Multiple-CPP Pass@1 | Multiple-JS Pass@1 | Fraction-Fit | Server Rounds | Comm Budget Used (GB) | Date       |
|--------------------------------------|--------------------------------|----------------|------------------|-------------|---------------------|--------------------|--------------|---------------|-----------------------|------------|
| [HuggingFaceTB/SmolLM2-1.7B-Instruct](SmolLM2-1.7B-nstruct-Coding)  | [Flwr-SmolLM2-1.7B-Instruct-Coding-PEFT](https://huggingface.co/ethicalabs/Flwr-SmolLM2-1.7B-Instruct-Coding-PEFT) | 26.68%         | 30.49%           | 34.00%      | 23.60%              | 18.63%             | 0.4          | 100           | 17.11                 | 13/03/2025 |
| [microsoft/Phi-4-mini-Instruct](Phi-4-mini-instruct-Coding)        | [Flwr-Phi-4-mini-Instruct-Coding-PEFT](https://huggingface.co/ethicalabs/Flwr-Phi-4-mini-Instruct-Coding-PEFT)   | 49.00%         | 59.76%           | 46.20%      | 37.27%              | 52.79%             | 0.2          | 10            | 3.66                  | 13/03/2025 |

---

## FlowerTune LLM - Finance

*(Coming soon)*
