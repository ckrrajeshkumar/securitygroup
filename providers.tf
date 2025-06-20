terraform {
  required_providers{
    aws={
      source= "hasicorp/aws"
      version ="6.0.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}