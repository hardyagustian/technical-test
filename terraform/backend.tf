terraform {
  backend "s3" {
    bucket         = "terraform_backend_prod"
    key            = "state/prod/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
  }
}
