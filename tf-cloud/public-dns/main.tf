terraform {
  cloud {
    organization = "ss027n4-home"
    workspaces {
      name = "route53-cloudflare"
    }
  }
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.0.0-alpha1"
    }
  }
}

provider "cloudflare" {
  # Configuration options
}

provider "aws" {
    region                  = var.aws_region
    assume_role {
      role_arn = "arn:aws:iam::639911800546:role/terraform-cloud-role"
    }

    default_tags {
        tags = {
            region = "${var.aws_region}"
            project = "${local.project_name}"
        }
    }
}