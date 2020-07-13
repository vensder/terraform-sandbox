# Create VPC
resource "aws_vpc" "sandbox" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = "true"    # gives you an internal domain name
  enable_dns_hostnames = "true"    # gives you an internal host name
  instance_tenancy     = "default" # dedicated is too expensive :)
  tags = {
    Name = "${var.name_tag}"
  }
}

# Create two subnets in the different AZ
resource "aws_subnet" "sandbox-a" {
  vpc_id                  = "${aws_vpc.sandbox.id}"
  cidr_block              = "${var.subnet_a_cidr}"
  map_public_ip_on_launch = "true"               # should be assigned a public IP address
  availability_zone       = "${var.aws_region}a" #  for ex.: "us-east-1a"
  tags = {
    Name = "${var.name_tag}-a"
  }
}

resource "aws_subnet" "sandbox-b" {
  vpc_id                  = "${aws_vpc.sandbox.id}"
  cidr_block              = "${var.subnet_b_cidr}"
  map_public_ip_on_launch = "true"               # should be assigned a public IP address
  availability_zone       = "${var.aws_region}b" # "us-east-1b"
  tags = {
    Name = "${var.name_tag}-b"
  }
}
