variable "aws_ssh_public_key" {}
variable "aws_ssh_private_key" {}
variable "aws_access_key_id" {}
variable "aws_secret_key" {}
variable "app_name" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "aws_instance_type" {
  default = "t2.micro"
}

variable "aws_ami_id" {
  default = "ami-6aaa2a13"
}
