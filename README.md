### IaC: DCOS
This terraform script with setup the DCOS cluster in AWS.
 - CentOS (Bootstrap Node)
 - CoreOS (Master and Agent Nodes)
 - Private subnet
 - Public subnet
 - Internet gateway

#### Pre-requisites
- An IAM account with administrator privileges.
- An existing infrastructure with a VPC, Subnet and instance from where this terraform can be run.
  We need the following information prior to starting the script.
  - public_security_group_id
  - public_subnet_id
  - vpc_id
  - aws_key_path
  - aws_key_name
  We have an [Iac-manager][iac-manager] which can do this task.
- Install terraform in the machine from [here][terraform-install].

#### Steps to install DCOS
- Clone this repo .
- Copy your AWS ssh key into current dir.
- `cp terraform.dummy terraform.tfvars`
- If you are using [Iac-Manager][iac-manager], there will be a file named `terraform.out` which will have the variable which are pre-requisites.
- Modify params in `terraform.tfvars`
- Modify params in `variable.tf` to change subnet or add AMI accordingly to your aws region
- Run `terraform plan` to see the plan to execute.
- Run `terraform apply` to run the scripts.
- You may have `prod/dev/stage` configurations in
`terraform.tfvars.{prod/dev/stage}` files (already ignored by `.gitignore`).

#### Notes
- The AWS key name, AWS key path, VPC, Subnet, Security Group will be updated to `terraform.dummy`
and AWS ssh key will be copied to the current directory if `IaC: Manager` installation is done.

[iac-manager]: <https://github.com/microservices-today/IaC-manager>
[terraform-install]: <https://www.terraform.io/intro/getting-started/install.html>