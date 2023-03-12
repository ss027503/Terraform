terraform {
  cloud {
    organization = "ss027n4-home"

    workspaces {
      name = "use2-temp-workstation"
    }
  }
}

provider "aws" {
    region                  = var.aws_region
    assume_role {
      role_arn = "arn:aws:iam::639911800546:role/terraform-cloud-role"
    }

    default_tags {
        tags = {
            region = "${var.aws_region}"
            project = "${var.project_name}"
        }
    }
}