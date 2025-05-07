# FlowerTune-LLM-Labs - Fine-tuned LLMs

The following fine-tuned LLMs are sent to the [FlowerTune LLM Leaderboard](https://flower.ai/benchmarks/llm-leaderboard/).

The goal is to evaluate LLMs on different domains of tasks, experiment with different fine-tuning techniques, and compare their performances across various domains.

---

## FlowerTune LLM - Coding

| Model                                | Adapter                                  | Average Pass@1 | HumanEval Pass@1 | MBPP Pass@1 | Multiple-CPP Pass@1 | Multiple-JS Pass@1 | Fraction-Fit | Server Rounds | Comm Budget Used (GB) | Date       |
|--------------------------------------|--------------------------------|----------------|------------------|-------------|---------------------|--------------------|--------------|---------------|-----------------------|------------|
| [microsoft/Phi-4-mini-Instruct](Phi-4-mini-instruct-Coding)          | [Flwr-Phi-4-mini-Instruct-Coding-PEFT](https://huggingface.co/ethicalabs/Flwr-Phi-4-mini-Instruct-Coding-PEFT)   | 49.00 %         | 59.76 %           | 46.20 %      | 37.27 %              | 52.79 %             | 0.2          | 10            | 3.66                  | 13/03/2025 |
| [Qwen/Qwen2.5-7B-Instruct](Qwen2.5-7B-Instruct-Coding)  | [Flwr-Qwen2.5-7B-Instruct-Coding-PEFT](https://huggingface.co/ethicalabs/Flwr-Qwen2.5-7B-Instruct-Coding-PEFT) | 34.40 %         | 25.00 %           | 48.00 %      | 54.04 %              | 10.56 %             | 0.2          | 10            | 2.01                 | 20/03/2025 |
| [HuggingFaceTB/SmolLM2-1.7B-Instruct](SmolLM2-1.7B-Instruct-Coding)  | [Flwr-SmolLM2-1.7B-Instruct-Coding-PEFT](https://huggingface.co/ethicalabs/Flwr-SmolLM2-1.7B-Instruct-Coding-PEFT)                | 26.93 %         | 30.49 %           | 35.00 %      | 23.60 %              | 18.63 %             | 0.4          | 100           | 17.11                 | 20/03/2025 |
| [Qwen/Qwen2.5-1.5B-Instruct](Qwen2.5-1.5B-Instruct-Coding)  | [Flwr-Qwen2.5-1.5B-Instruct-Coding-PEFT](https://huggingface.co/ethicalabs/Flwr-Qwen2.5-1.5B-Instruct-Coding-PEFT) | 17.82 %         | 7.93 %           | 23.60 %      | 26.09 %               | 13.66 %             | 0.4          | 20            | 3.68                 | 20/03/2025 |
| [Qwen/Qwen2.5-0.5B-Instruct](Qwen2.5-0.5B-Instruct-Coding)  | [Flwr-Qwen2.5-0.5B-Instruct-Coding-PEFT](https://huggingface.co/ethicalabs/Flwr-Qwen2.5-0.5B-Instruct-Coding-PEFT) | 16.49 %        | 22.56 %           | 20.40 %      | 16.15 %               | 6.83 %              | 0.6          | 30            | 3.95                 | 20/03/2025 |


---

## FlowerTune LLM - Medical

| Model                                | Adapter                                  | Average Accuracy | CareQA Accuracy | MedmcQA Accuracy | MedQA Accuracy | PubMedQA Accuracy | Fraction-Fit | Server Rounds | Comm Budget Used (GB) | Date       |
|--------------------------------------|--------------------------------|----------------|------------------|-------------|---------------------|--------------------|--------------|---------------|-----------------------|------------|
| [Qwen/Qwen3-0.6B](Qwen3-0.6B-Medical)          | [Flwr-Qwen3-0.6B-Medical-PEFT](https://huggingface.co/ethicalabs/Flwr-Qwen3-0.6B-Medical-PEFT)   | 21.94 %         | 26.86 %           | 20.13 %      | 20.35 %              | 20.40 %          | 0.2            | 50                  | 8.25         | 04/05/2025        |
