
output "vpc_id" {
  value = "${aws_vpc.sandbox.id}"
}

output "subnet_a_id" {
    value = "${aws_subnet.sandbox-a.id}"
}

output "subnet_b_id" {
    value = "${aws_subnet.sandbox-b.id}"
}