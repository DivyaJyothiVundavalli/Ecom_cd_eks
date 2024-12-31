terraform {
  backend "s3" {
    bucket = "ecomappbucket1"
    key    = "eks/terraform.tfstate"
    region = "ap-south-1"
  }
}
