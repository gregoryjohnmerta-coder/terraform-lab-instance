terraform {
  backend "s3" {
     bucket = "boa-terraform-stat-im-jan25-user3"
     key = "dev/terraform.tfstate"
     region = "ap-south-1"
     encrypt = true
     dynamodb_table = "terraform-locks-user3"
  }
}