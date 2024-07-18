# habi-project
habi-project
# AWS Architecture with Terraform

This project demonstrates the setup of an AWS architecture using Terraform, including two Lambda functions, an SQS queue, an RDS MySQL database, and an Aurora cluster.

## Architecture Diagram

### Lambda and SQS Architecture

```plaintext
          +---------------------+            +--------------------+            +---------------------+
          |  EventBridge Rule   |  ------->  |   Lambda (SQS)     |  ------->  |       SQS Queue     |
          +---------------------+            +--------------------+            +---------------------+
                                                          |                                    |
                                                          |                                    |
                                                          v                                    v
                                            +---------------------+            +---------------------+
                                            | Lambda (RDS Writer) |  <-------  |     Aurora Cluster  |
                                            +---------------------+            +---------------------+

          +-------------------------------------+
          |          AWS Cloud                  |
          |                                     |
          |  +------------------------------+   |
          |  |     VPC                      |   |
          |  |  +-----------------------+   |   |
          |  |  |   Aurora Cluster      |   |   |
          |  |  |                       |   |   |
          |  |  |  +----------------+   |   |   |
          |  |  |  |  Instance 1    |   |   |   |
          |  |  |  +----------------+   |   |   |
          |  |  |  +----------------+   |   |   |
          |  |  |  |  Instance 2    |   |   |   |
          |  |  |  +----------------+   |   |   |
          |  |  |  +----------------+   |   |   |
          |  |  |  |  Instance 3    |   |   |   |
          |  |  |  +----------------+   |   |   |
          |  |  +-----------------------+   |   |
          |  +------------------------------+   |
          +-------------------------------------+
```       
# Prerequisites
Terraform 0.12+
AWS CLI configured with appropriate permissions
An existing VPC with subnets and security groups

## Infrastructure Deployment with Terraform and GitLab CI/CD

This project sets up an AWS infrastructure using Terraform, with CI/CD integration in GitLab. The setup includes validation, deployment of infrastructure, deployment of Lambda functions, and conditional destruction of infrastructure based on environment variables.

### Table of Contents

- [Infrastructure Deployment with Terraform and GitLab CI/CD](#infrastructure-deployment-with-terraform-and-gitlab-cicd)
  - [Table of Contents](#table-of-contents)
  - [Part 1: Bash Script](#part-1-bash-script)
    - [Objective](#objective)
    - [Requirements](#requirements)
    - [Script](#script)
    - [Integration with GitLab Pipeline](#integration-with-gitlab-pipeline)
  - [Part 2: CI/CD in GitLab](#part-2-cicd-in-gitlab)
    - [Objective](#objective-1)
    - [Pipeline Configuration](#pipeline-configuration)
    - [Pipeline Execution](#pipeline-execution)
  - [License](#license)

### Part 1: Bash Script

#### Objective

Create a Bash script that performs validations and specific actions based on environment variables in GitLab.

#### Requirements

- The script must:
  - Check if a variable in GitLab called `DESTROY_INFRA` exists to determine if a `terraform destroy` command should be executed.
  - If `DESTROY_INFRA` is set to `true`, execute the `terraform destroy` command.
  - If `DESTROY_INFRA` is set to `false` or does not exist, do not execute the `terraform destroy` command.
  - Document the script and explain how to integrate it into the GitLab pipeline.

#### Script

Create a file named `terraform_destroy.sh` with the following content:

```bash
#!/bin/bash

# Verificar si la variable DESTROY_INFRA está establecida
if [ "$DESTROY_INFRA" == "true" ]; then
  echo "DESTROY_INFRA is set to true. Running 'terraform destroy'..."
  terraform destroy -auto-approve
else
  echo "DESTROY_INFRA is not set to true o not exists.'."
fi
