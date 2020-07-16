# Create VPC
module "vpc" {
  source        = "./modules/vpc"
  vpc_cidr      = "10.0.2.0/23"
  subnet_a_cidr = "10.0.2.0/24"
  subnet_b_cidr = "10.0.3.0/24"
  vpc_id        = "${module.vpc.vpc_id}"
  aws_region    = "${var.aws_region}"
  name_tag      = "my_sandbox"
}

# Create Internet Gateway
resource "aws_internet_gateway" "sandbox_igw" {
  vpc_id = "${module.vpc.vpc_id}"
  tags = {
    Name = "sandbox_igw"
  }
}

# Create Custom Route Table
resource "aws_route_table" "sandbox_crt" {
  vpc_id = "${module.vpc.vpc_id}"

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = "${aws_internet_gateway.sandbox_igw.id}"
  }

  tags = {
    Name = "sandbox_crt"
  }
}

# Associate CRT and Subnets
resource "aws_route_table_association" "sandbox_crta_subnet_a" {
  subnet_id      = "${module.vpc.subnet_a_id}"
  route_table_id = "${aws_route_table.sandbox_crt.id}"
}

resource "aws_route_table_association" "sandbox_crta_subnet_b" {
  subnet_id      = "${module.vpc.subnet_b_id}"
  route_table_id = "${aws_route_table.sandbox_crt.id}"
}

# Create s Security Group
resource "aws_security_group" "ssh_http_allowed" {
  vpc_id = "${module.vpc.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // all ip address are allowed to ssh 
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh_http_allowed"
  }
}
