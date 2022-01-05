terraform {
  backend "s3" {
    bucket = "sqltest123"
    key    = "terraform/state/terraform.tfstate"
    region = "ap-south-1"
  }
}