# Terraform AWS Infrastructure Automation with GitHub Actions

This repository automates AWS infrastructure provisioning and destruction using Terraform. The process is integrated with GitHub Actions to enable seamless CI/CD workflows for infrastructure management.

## Folder Structure


.github/workflows    # GitHub Actions workflows for automation
.gitignore           # Files and directories to ignore in Git
.terraform.lock.hcl  # Terraform lock file to ensure consistent provider versions
backend.tf           # Terraform backend configuration for state management
main.tf              # Main Terraform configuration file
provider.tf          # Provider configuration (e.g., AWS)
variable.tf          # Input variables for Terraform modules


## Workflows

### 1. Terraform Workflow

This workflow performs `terraform plan` on pull requests and `terraform apply` when changes are merged into the `main` branch.

#### Trigger Events:
- Pull Requests targeting the `main` branch
- Pushes to the `main` branch

#### Key Steps:
- **Checkout**: Clones the repository to the GitHub Actions runner.
- **Setup Terraform**: Installs Terraform CLI (version 0.14.3).
- **Terraform Init**: Initializes Terraform.
- **Terraform Plan**: Generates and displays an execution plan (on pull requests).
- **Terraform Apply**: Provisions infrastructure automatically (on merges to `main`).

### 2. Terraform Destroy Workflow

This workflow allows you to destroy the AWS infrastructure when necessary.

#### Trigger Events:
- Manually via `workflow_dispatch` from the GitHub UI
- Optionally on pull requests targeting the `main` branch

#### Key Steps:
- **Checkout**: Clones the repository to the GitHub Actions runner.
- **Setup Terraform**: Installs Terraform CLI (version 0.14.3).
- **Terraform Init**: Initializes Terraform.
- **Terraform Destroy**: Destroys all provisioned resources with `-auto-approve`.

## Prerequisites

1. **AWS Credentials**:
   - Configure AWS secrets (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`) in your repository's GitHub Secrets.

2. **Terraform Version**:
   - Ensure compatibility with Terraform version `0.14.3`.

3. **Remote State Management**:
   - Update the `backend.tf` file with your preferred backend (e.g., AWS S3) for state locking and persistence.

## How to Use

### Setting Up the Repository
1. Clone this repository:
   
   git clone <repository-url>
  
2. Navigate to the repository:
 
   cd <repository-folder>
   
3. Install Terraform CLI locally (if required):
 
   terraform -version
  

### Modifying Infrastructure
1. Edit the Terraform configuration files (`main.tf`, `variable.tf`, etc.) as needed.
2. Commit your changes:
  
   git add .
   git commit -m "Updated infrastructure configuration"
   git push origin <branch-name>

3. Create a pull request targeting the `main` branch. The workflow will run `terraform plan` to validate the changes.
4. Merge the pull request to apply the changes.

### Destroying Infrastructure
1. Navigate to the GitHub Actions tab in your repository.
2. Select the **Terraform Destroy** workflow.
3. Click **Run workflow** to manually trigger infrastructure destruction.

## Files Overview

### `.gitignore`
Specifies files and directories to be ignored by Git, such as:
- `.terraform/`
- `.terraform.lock.hcl`
- Terraform state files (e.g., `*.tfstate` and `*.tfstate.backup`)

### `backend.tf`
Configures the backend for storing Terraform state. Example:

terraform {
  backend "s3" {
    bucket         = "your-s3-bucket"
    key            = "terraform/state"
    region         = "your-region"
    dynamodb_table = "your-dynamodb-table"
    encrypt        = true
  }
}


### `main.tf`
Defines the main resources to be provisioned in AWS.

### `provider.tf`
Specifies the AWS provider and its configurations. Example:

provider "aws" {
  region = var.region
}


### `variable.tf`
Defines input variables for the Terraform modules. Example:

variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}


## Best Practices
- Use a remote backend for state management.
- Use GitHub branch protection rules to require workflow checks before merging.
- Periodically review and rotate AWS credentials.
- Use environment-specific workspaces for staging and production.

## References
- [Terraform Documentation](https://www.terraform.io/docs/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)



