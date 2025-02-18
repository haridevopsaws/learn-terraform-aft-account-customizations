provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "main" {
  cidr_block = "10.20.0.0/16"
  tags = {
    "Name" = "hari-vpc"
    "Environment": "Dev"
  }
}