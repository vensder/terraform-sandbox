# Create VPC
module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.2.0/23"
  subnet_a_cidr = "10.0.2.0/24"
  subnet_b_cidr = "10.0.3.0/24"
  vpc_id = "${module.vpc.vpc_id}"
  aws_region = "${var.aws_region}"
  name_tag = "my-sandbox"
}
