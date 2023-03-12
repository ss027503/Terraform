variable "aws_region" {
    default = "us-east-2"
}

variable "vpc_id" {
    default = "vpc-87d13fee"
}

variable "root_volume_size" {
    default = 60
}

variable "home_ip" {
    default = ""
}

variable "instance_type" {
    default = "t3.small"
}

variable "instance_key" {
    default = "home-use2"
}