terraform {
  backend "s3" {
    bucket = "calderalabs-terraform"
    region = "eu-west-1"
  }
}
