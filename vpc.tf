# Create VPC
resource "aws_vpc" "awesome-sandbox-tf" {
  cidr_block           = "10.0.2.0/23"
  enable_dns_support   = "true"    # gives you an internal domain name
  enable_dns_hostnames = "true"    # gives you an internal host name
  instance_tenancy     = "default" # dedicated is too expensive :)
  tags = {
    Name = "awesome-sandbox-tf"
  }
}

# Create two subnets in the different AZ
resource "aws_subnet" "awesome-sandbox-tf-1a" {
  vpc_id                  = "${aws_vpc.awesome-sandbox-tf.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"               # should be assigned a public IP address
  availability_zone       = "${var.AWS_REGION}a" #  for ex.: "us-east-1a"
  tags = {
    Name = "awesome-sandbox-tf-1a"
  }
}

resource "aws_subnet" "awesome-sandbox-tf-1b" {
  vpc_id                  = "${aws_vpc.awesome-sandbox-tf.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"               # should be assigned a public IP address
  availability_zone       = "${var.AWS_REGION}b" # "us-east-1b"
  tags = {
    Name = "awesome-sandbox-tf-1b"
  }
}

