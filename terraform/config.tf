terraform {
  backend "s3" {
    bucket = "caldera-terraform"
    key = "YOUR_APP_NAME"
    region = "eu-west-1"
  }
}
