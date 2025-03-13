# FlowerTune LLM Leaderboard

These fine-tunes are sent to the [FlowerTune LLM Leaderboard](https://flower.ai/benchmarks/llm-leaderboard/), which evaluates large language models fine-tuned in federated learning environments.

The goal is to evaluate LLMs on different domains of tasks, experiment with different fine-tuning techniques, and compare their performances across various domains.

---

## FlowerTune LLM - Coding

| Model                                | Average Pass@1 | HumanEval Pass@1 | MBPP Pass@1 | Multiple-CPP Pass@1 | Multiple-JS Pass@1 | Fraction-Fit | Server Rounds | Comm Budget Used (GB) | Date       |
|--------------------------------------|----------------|------------------|-------------|---------------------|--------------------|--------------|---------------|-----------------------|------------|
| HuggingFaceTB/SmolLM2-1.7B-Instruct  | 26.68%         | 30.49%           | 34.00%      | 23.60%              | 18.63%             | 0.4          | 100           | 17.11                 | 13/03/2025 |
| microsoft/Phi-4-mini-Instruct        | 49.00%         | 59.76%           | 46.20%      | 37.27%              | 52.79%             | 0.2          | 10            | 3.66                  | 13/03/2025 |

---

## FlowerTune LLM - Finance

*(Coming soon)*
