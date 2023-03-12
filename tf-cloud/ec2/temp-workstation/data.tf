data "aws_ami" "win2022" {
    most_recent         = true
    filter {
        name            = "name"
        values          = ["Windows_Server-2022-English-Full-Base-*"]
    }
    filter {
        name            = "virtualization-type"
        values          = ["hvm"]
    }
    owners              = ["amazon"]
}

data "aws_subnet" "this" {
    vpc_id  = var.vpc_id
    filter {
        name    = "availabilityZone"
        values  = ["us-east-1c"]
    }
}

