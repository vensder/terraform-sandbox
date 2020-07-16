
output "vpc_id" {
  value = "${aws_vpc.sandbox.id}"
}

output "subnet_a_id" {
  value = "${aws_subnet.sandbox_a.id}"
}

output "subnet_b_id" {
  value = "${aws_subnet.sandbox_b.id}"
}