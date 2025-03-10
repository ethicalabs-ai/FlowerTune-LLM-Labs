# Terraform Infrastructure Setup for FlowerTune

## Overview

This folder contains a Terraform configuration to set up infrastructure for FlowerTune on [CUDO Compute](https://www.cudocompute.com/?via=flowertune-llm).

The configurations will deploy the required resources for your FlowerTune experiments.

### Folder Structure

- `infra_example`: Example folder containing infrastructure setup for FlowerTune.
- `modules`: Contains the main module for infrastructure components.

## Setup Instructions

### Prerequisites

Before running Terraform, ensure you have the following:

1. **Terraform**: Install Terraform if not already installed. Follow [Terraform Installation Guide](https://developer.hashicorp.com/terraform/install).
2. **CUDO API Key**: Set up a CUDO account and generate your API key.
3. **CUDO Project ID**: Ensure you have access to a CUDO project where you can provision resources.

### Environment Variables

Set the following environment variables to configure your infrastructure:

```bash
export TF_VAR_cudo_api_key="your-cudo-api-key"
export TF_VAR_cudo_project_id="your-cudo-project-id"
```

### Steps to Deploy

1. **Navigate to the Infrastructure Directory**:
   Change to the `infra_example` directory:

   ```bash
   cd infra_example
   ```

2. **Initialize Terraform**:
   Run the Terraform initialization command to download required providers and set up the environment:

   ```bash
   terraform init
   ```

3. **Plan the Deployment**:
   Preview the resources that will be created by running:

   ```bash
   terraform plan
   ```

4. **Apply the Configuration**:
   Apply the Terraform configuration to provision the infrastructure:

   ```bash
   terraform apply
   ```

5. **Check the Output**:
   After the successful application, check the output for the IP address of the deployed resources.

   Example output:

   ```bash
   module.llm_experiment.cudo_vm.flowertune_vm: Creating...
   module.llm_experiment.cudo_vm.flowertune_vm: Still creating... [10s elapsed]
   module.llm_experiment.cudo_vm.flowertune_vm: Still creating... [20s elapsed]
   module.llm_experiment.cudo_vm.flowertune_vm: Creation complete after 21s [id=flowertune-vm]

   Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

   Outputs:

   external_ip_address = "x.x.x.x"
   renewable_energy = false
   ```

The startup script will run in the background in the provisioned VM. Once the script is executed, please login via SSH using the provided `flower` user:

```
ssh flower@x.x.x.x
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 5.15.0-122-generic x86_64)
...
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```

To remove all infrastructure resources, please run:

```bash
terraform destroy
```


## Notes

- Ensure you have the necessary SSH public key in your CUDO user account.
- This setup is intended for experimentation and resource optimization with FlowerTune LLM, not for production usage.
