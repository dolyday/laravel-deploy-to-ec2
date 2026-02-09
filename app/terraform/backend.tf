terraform {
  backend "s3" {
    bucket         = "rayan-terraform-state-bucket"
    key            = "terraform/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}