variable "ssh_public_key" {}
variable "aws_access_key_id" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "app_name" {}

variable "aws_instance_type" {
  default = "t2.micro"
}
