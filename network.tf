# Create Internet Gateway
resource "aws_internet_gateway" "sandbox-igw" {
  vpc_id = "${module.vpc.vpc_id}"
  tags = {
    Name = "sandbox-igw"
  }
}

# Create Custom Route Table
resource "aws_route_table" "sandbox-crt" {
  vpc_id = "${module.vpc.vpc_id}"

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = "${aws_internet_gateway.sandbox-igw.id}"
  }

  tags = {
    Name = "sandbox-crt"
  }
}

# Associate CRT and Subnets
resource "aws_route_table_association" "sandbox-crta-subnet-a" {
  subnet_id      = "${module.vpc.subnet_a_id}"
  route_table_id = "${aws_route_table.sandbox-crt.id}"
}

resource "aws_route_table_association" "sandbox-crta-subnet-b" {
  subnet_id      = "${module.vpc.subnet_b_id}"
  route_table_id = "${aws_route_table.sandbox-crt.id}"
}

# Create s Security Group
resource "aws_security_group" "ssh-http-allowed" {
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
    Name = "ssh-http-allowed"
  }
}
