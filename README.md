# Simple Terraform Deployment

This terraform plan creates VPC, Subnets, Internet Gateway, Custom Route Table, Security Group and deploys EC2 instance with nginx installation.

## How to deploy

Download terraform for your platform and unarchive it to the subdirectory in your home dir, for ex.:

~/.local/bin/

Add this directory to your system's $PATH environment variable, if it is not added.

Check the terraform version:

```bash
terraform --version
Terraform v0.12.20
```

Create AWS Access key and secret, export them in the current bash session:

```bash
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
```

Initialize a working directory and view an execution plan:

```bash
terraform init

terraform plan
```

Apply the plan:

```bash
terraform apply
```

Open the web-site on the deployed EC2 instance, for example:

http://ec2-54-226-83-36.compute-1.amazonaws.com/

![Deployed Web Page](./img/screenshot.png?raw=true)

## How to destroy

Exterminate everything:

```bash
terraform destroy
```
