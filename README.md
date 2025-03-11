# FlowerTune LLM Labs

## Overview

FlowerTune LLM Labs is a collection of cookiecutter templates designed to help developers set up federated fine-tuning experiments using [Flower](https://flower.ai/) and [CUDO Compute](https://www.cudocompute.com/?via=flowertune-llm).

This project provides ready-to-use Terraform modules, startup scripts, and example configurations to simplify running LLM fine-tuning in a federated learning setting.

With CUDO Compute, individual developers can leverage high-performance NVIDIA GPUs for AI workloads without requiring access to large-scale infrastructure.

By combining DevOps best practices such as infrastructure as code (IaC) with Flower's federated learning framework, we enable scalable and reproducible AI/ML research.

---

For more details about the FlowerTune LLM initiative, pleasse visit [FlowerTune LLM Leaderboard](https://flower.ai/benchmarks/llm-leaderboard/) 🚀

## Features

- Cookiecutter-based project templates for easy experiment setup.
- Terraform modules for provisioning CUDO Compute resources.
- Automated startup script to install system dependencies.
- Preconfigured Flower simulation engine for federated LLM fine-tuning.

## Getting Started

1. Clone the Repository

```
git clone git@github.com:ethicalabs-ai/FlowerTune-LLM-Labs.git
cd FlowerTune-LLM-Labs
```

2. Initialize a New Experiment Using Cookiecutter

You can use Cookiecutter to generate a new project structure for a federated FlowerTune experiment:

```
pip install -r requirements.txt

cd workspace
cookiecutter ../templates/FlowerTune-LLM-Coding
```

Example Run:

```
✗ cd workspace
✗ cookiecutter ../templates/FlowerTune-LLM-Coding
  [1/24] directory_name (Coding-LLM):
  [2/24] accumulation_steps (1):
  [3/24] base_model (Qwen/Qwen2.5-Coder-0.5B-Instruct):
  ...
  [24/24] version (1.0.0):
```

This command will create a fully structured project with all necessary configurations for running federated fine-tuning experiments.

## Deploying Infrastructure on CUDO Compute

This repository includes Terraform configurations to deploy required resources on CUDO Compute.

📌 For detailed setup instructions, see [terraform/README.md](./terraform/README.md).

## Next Steps: Containerizing Your Experiment

This project is part of an ongoing series on democratizing AI compute. In the next phase, we will introduce Docker-based deployment, allowing us to:

- ✅ Avoid installing dependencies manually.
- ✅ Use containerized environments for cleaner deployments (Docker, Kubernetes).
- ✅ Move toward best practices in DevOps and MLOps.

Stay tuned for the next guide on containerizing federated LLM fine-tuning with Docker!

## Contribute & Support

This project is open-source and community-driven. If you’d like to support further experiments and research, consider contributing via Open Collective:

👉 Support the [FlowerTune LLM Labs](https://opencollective.com/ethicalabs-ai/projects/flowertune-llm-lab) 🚀
