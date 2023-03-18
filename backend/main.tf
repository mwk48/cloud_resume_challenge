provider "aws" {
    region = "us-east-1"
    profile = "dev-resume"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
    region = data.aws_region.current.name
}

output "account_id" {
    value = local.account_id
}

output "region" {
    value = local.region
}



