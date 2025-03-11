# FlowerTune LLM Labs

## Overview

FlowerTune LLM Labs is a collection of cookiecutter templates designed to help developers set up federated fine-tuning experiments using [Flower](https://flower.ai/) and [CUDO Compute](https://www.cudocompute.com/?via=flowertune-llm).

This project provides ready-to-use [Terraform](https://www.terraform.io/) modules, startup scripts, and example configurations to simplify running LLM fine-tuning in a federated learning setting.

With [CUDO Compute](https://www.cudocompute.com/?via=flowertune-llm), individual developers can leverage high-performance NVIDIA GPUs for AI workloads without requiring access to large-scale infrastructure.

By combining DevOps best practices such as infrastructure as code (IaC) with Flower's federated learning framework, we enable scalable and reproducible AI/ML research.

---

For more details about the FlowerTune LLM initiative, pleasse visit [FlowerTune LLM Leaderboard](https://flower.ai/benchmarks/llm-leaderboard/) 🚀

## Features

- [Cookiecutter](https://cookiecutter.readthedocs.io)-based project templates for easy experiment setup.
- Terraform modules for provisioning CUDO Compute resources.
- Automated startup script to install system dependencies.
- Preconfigured Flower simulation engine for federated LLM fine-tuning.

## Getting Started

### Clone the Repository

```
git clone git@github.com:ethicalabs-ai/FlowerTune-LLM-Labs.git
cd FlowerTune-LLM-Labs
```

### Initialize a New Experiment Using Cookiecutter

You can use Cookiecutter to generate a new project structure for a federated FlowerTune experiment:

```
pip install -r requirements.txt

cd workspace
cookiecutter ../templates/FlowerTune-LLM-Coding
```

### Example Run

```
➜  FlowerTune-LLM-Labs git:(main) cd workspace
➜  workspace git:(main) ✗ ls
➜  workspace git:(main) ✗ cookiecutter ../templates/FlowerTune-LLM-Coding

  [1/25] directory_name (Coding-LLM):
  [2/25] project_name (FlowerTune-LLM-Coding):
  [3/25] project_short_description (FlowerTune LLM Labs - Coding Template):
  [4/25] full_name (Individual Contributor):
  [5/25] email (hello@flower.ai):
  [6/25] flower_username (flower):
  [7/25] base_model (Qwen/Qwen2.5-Coder-0.5B-Instruct):
  [8/25] quantization (4):
  [9/25] bf16 (true):
  [10/25] tf32 (true):
  [11/25] peft_lora_alpha (64):
  [12/25] peft_lora_r (32):
  [13/25] peft_use_dora (true):
  [14/25] per_device_train_batch_size (8):
  [15/25] max_steps (10):
  [16/25] accumulation_steps (1):
  [17/25] max_lr (5e-5):
  [18/25] min_lr (5e-6):
  [19/25] optimizer (paged_adamw_8bit):
  [20/25] lr_scheduler_type (constant):
  [21/25] fraction_fit (0.2):
  [22/25] num_server_rounds (100):
  [23/25] gpu_spec (NVIDIA RTX A4000):
  [24/25] project_slug (flowertune_llm_coding):
  [25/25] version (1.0.0):
```

This command will create a fully structured project with all necessary configurations for running federated fine-tuning experiments.

## Deploying Infrastructure on CUDO Compute

This repository includes Terraform configurations to deploy required resources on [CUDO Compute](https://www.cudocompute.com/?via=flowertune-llm).

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
