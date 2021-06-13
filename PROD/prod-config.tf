provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "my-s3-bucket-for-terraform"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}
