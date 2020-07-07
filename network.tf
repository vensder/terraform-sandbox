# Create Internet Gateway
resource "aws_internet_gateway" "awesome-sandbox-tf-igw" {
  vpc_id = "${aws_vpc.awesome-sandbox-tf.id}"
  tags = {
    Name = "awesome-sandbox-tf-igw"
  }
}

# Create Custom Route Table
resource "aws_route_table" "awesome-sandbox-tf-crt" {
  vpc_id = "${aws_vpc.awesome-sandbox-tf.id}"

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = "${aws_internet_gateway.awesome-sandbox-tf-igw.id}"
  }

  tags = {
    Name = "awesome-sandbox-tf-crt"
  }
}

# Associate CRT and Subnets
resource "aws_route_table_association" "awesome-sandbox-tf-crta-subnet-1a" {
  subnet_id      = "${aws_subnet.awesome-sandbox-tf-1a.id}"
  route_table_id = "${aws_route_table.awesome-sandbox-tf-crt.id}"
}

resource "aws_route_table_association" "awesome-sandbox-tf-crta-subnet-1b" {
  subnet_id      = "${aws_subnet.awesome-sandbox-tf-1b.id}"
  route_table_id = "${aws_route_table.awesome-sandbox-tf-crt.id}"
}

# Create s Security Group
resource "aws_security_group" "ssh-http-allowed" {
  vpc_id = "${aws_vpc.awesome-sandbox-tf.id}"

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
