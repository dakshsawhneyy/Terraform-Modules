terraform {
  backend "s3" {
    bucket = "daksh-s3-bucket-2005"
    region = "ap-south-1"
    key = "daksh/terraform.tfstate"
    dynamodb_table = "terraform_lock"
  }
}
