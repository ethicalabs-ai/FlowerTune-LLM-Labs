# FlowerTune LLM Labs

## Overview

FlowerTune LLM Labs is a collection of cookiecutter templates designed to help developers set up federated fine-tuning experiments using [Flower](https://flower.ai/) and [CUDO Compute](https://www.cudocompute.com/?via=flowertune-llm).

This project provides ready-to-use [Terraform](https://www.terraform.io/) modules, startup scripts, and example configurations to simplify running LLM fine-tuning in a federated learning setting.

With [CUDO Compute](https://www.cudocompute.com/?via=flowertune-llm), individual developers can leverage high-performance NVIDIA GPUs for AI workloads without requiring access to large-scale infrastructure.

By combining DevOps best practices such as infrastructure as code (IaC) with Flower's federated learning framework, we enable scalable and reproducible AI/ML research.

---

For more details about the FlowerTune LLM initiative, please visit [FlowerTune LLM Leaderboard](https://flower.ai/benchmarks/llm-leaderboard/) 🚀

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
➜  workspace git:(main) ✗ cookiecutter ../templates/FlowerTune-LLM-Coding

  [1/27] directory_name (Coding-LLM): Qwen2.5-Coder
  [2/27] project_name (FlowerTune-LLM-Coding):
  [3/27] project_short_description (FlowerTune LLM Labs - Coding Template):
  [4/27] full_name (Individual Contributor):
  [5/27] email (hello@flower.ai):
  [6/27] flower_username (flower):
  [7/27] base_model (Qwen/Qwen2.5-Coder-0.5B-Instruct):
  [8/27] quantization (4):
  [9/27] bf16 (true):
  [10/27] tf32 (true):
  [11/27] peft_lora_alpha (64):
  [12/27] peft_lora_r (32):
  [13/27] peft_use_dora (true):
  [14/27] per_device_train_batch_size (8):
  [15/27] max_steps (10):
  [16/27] accumulation_steps (1):
  [17/27] max_lr (5e-5):
  [18/27] min_lr (5e-6):
  [19/27] optimizer (paged_adamw_8bit):
  [20/27] lr_scheduler_type (constant):
  [21/27] fraction_fit (0.2):
  [22/27] num_server_rounds (100):
  [23/27] num_cpus (4):
  [24/27] num_gpus (1.0):
  [25/27] gpu_spec (NVIDIA RTX A4000):
  [26/27] project_slug (flowertune_llm_coding):
  [27/27] version (1.0.0):
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
