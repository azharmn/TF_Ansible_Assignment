terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">=1.2.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
  access_key = "Access_key"
  secret_key = "Secret_key"

}