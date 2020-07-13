output "instance_ips" {
  value = "${aws_instance.nginx.public_ip}"
}