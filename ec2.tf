resource "aws_instance" "nginx" {

  ami           = "${lookup(var.ami, var.aws_region)}"
  instance_type = "t3.nano"

  # VPC
  subnet_id = "${module.vpc.subnet_a_id}"

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-http-allowed.id}"]


  user_data = <<EOF
#!/usr/bin/env bash
sudo apt-get update
sudo apt-get -y install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo '''
<h1>Deployed via Awesome Terraform</h1>
</br>
<img src="https://www.terraform.io/assets/images/logo-hashicorp-3f10732f.svg" style="width:70%";>
''' | sudo tee /var/www/html/index.nginx-debian.html
EOF

  tags = {
    Name = "MyAwesomeInstance"
  }
}
