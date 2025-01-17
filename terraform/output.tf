output "main-prod-vpc-out" {
  value = "${aws_vpc.main-prod-vpc.id}"
}

#############################

output "main-prod-private-subnet-a-out" {
  value = "${aws_subnet.main-prod-private-subnet-a.id}"
}
output "main-prod-private-subnet-b-out" {
  value = "${aws_subnet.main-prod-private-subnet-b.id}"
}
output "main-prod-private-subnet-c-out" {
  value = "${aws_subnet.main-prod-private-subnet-c.id}"
}
output "main-prod-public-subnet-a-out" {
  value = "${aws_subnet.main-prod-public-subnet-a.id}"
}
output "main-prod-public-subnet-b-out" {
  value = "${aws_subnet.main-prod-public-subnet-b.id}"
}
output "main-prod-public-subnet-c-out" {
  value = "${aws_subnet.main-prod-public-subnet-c.id}"
}
###################################

### SG #####
#######################################
output "allow-http-s-prod-vpc-out" {
  value = "${aws_security_group.allow-http-s-prod-vpc.id}"
}
output "allow-ssh-prod-vpc-out" {
  value = "${aws_security_group.allow-ssh-prod-vpc.id}"
}
#output "allow-http-s-prod-alb-out" {
#  value = "${aws_security_group.allow-http-s-prod-alb.id}"
#}
