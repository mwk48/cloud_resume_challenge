terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 2.0"
    }
  }

}

provider "aws" {
}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}

variable "cloudflare_account_id" {
  type        = string
  default     = ""
  description = "cloudflare account id"
}

variable "CLOUDFLARE_API_TOKEN" {
  type        = string
  default     = ""
  description = "cloudflare api token"
}


data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id  = data.aws_caller_identity.current.account_id
  region      = data.aws_region.current.name
  domain_name = "wingkin.eu.org"
  origin_id   = "s3-${aws_s3_bucket.bucket.bucket}"
}

output "account_id" {
  value = local.account_id
}

output "region" {
  value = local.region
}

output "domain_name" {
  value = local.domain_name
}

output "origin_id" {
  value = local.origin_id
}



