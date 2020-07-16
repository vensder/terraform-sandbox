resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfKSiUnU/u8WSn1VWab7p4xJuZgOnN9ydbKUGAGGU5jCSMH2njWsU4KRtdvrWGcSkFSNiufzFs6cXqIOi1fhM6t5weJGLsqL9cpRQgS7oUSMOeo6vii45xksNUU4tLHjz6RCCOnKmleUwPmFffVrWiCgnzwQcWBQQ7wvLoUt2qC58b9dFuh2ueNizanWaCTXCL2675on6kvB9rfbQXJ1cZy+y/z0Tsxp74wv3AuzclZDUSoX5xcEwJr7VN6HPfjAm0ZpJxHPgjPXoceqzWVs896pEfOqxAKH0eK4FW5FBM8EQSjspjpehYM4pWT4h5VmhEznYcD0kBaAopvdxSwg4P my@key"
}

resource "aws_instance" "nginx" {
  key_name               = "${aws_key_pair.my_key.key_name}"
  ami                    = "${lookup(var.ami, var.aws_region)}"
  instance_type          = "t3.nano"
  subnet_id              = "${module.vpc.subnet_a_id}"
  vpc_security_group_ids = ["${aws_security_group.ssh_http_allowed.id}"]

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
    Name = "my_instance"
  }
}
