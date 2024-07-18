# habi-project
habi-project
# Overview
This project, habi-project, involves creating a comprehensive infrastructure using Terraform. The main components of this infrastructure are:

## Aurora cluster with three instances
   * One endpoint
   * Related security groups
   * VPC access only
   * Dynamic Aurora Domain
   * The infrastructure includes a dynamic Aurora domain created by setting various parameters such as instance numbers. This allows for flexible and scalable database configurations.

## Components:
### Aurora Cluster

 * Three instances (This number is for example purposes, can be changed)
 * One endpoint
 * Related security groups
 * VPC access only
 * Autoscale for read replicas
 
### CloudWatch Alarms

  * Alarms related to the database, also created in Terraform.
  
## SQS Queue and Lambda Functions
   The infrastructure also includes the creation of an SQS queue and the required Lambda functions to process events.

### Lambda Functions:
   #### Lambda Write SQS (lambda_write_sqs)
   * Triggered by an EventBridge daily-based event.
   * Purpose: Once triggered, it sends an event to the SQS queue.
     
### Lambda Write RDS (lambda_write_rds)

* Triggered by the SQS queue.
* Purpose: Takes the event from the SQS queue and writes to the Aurora cluster.

## Environment Variables Management
* The environment variables are configured using a tool called SOPS.
* SOPS is used to manage versions of sensitive variables, such as the database password.
* Variables can only be read if the user has permissions to Secrets Manager.


## Architecture Diagram

### Lambda and SQS Architecture

![image](https://github.com/user-attachments/assets/fc63bdab-c8f0-49c6-9cfe-17ef5a2ca83d)

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
