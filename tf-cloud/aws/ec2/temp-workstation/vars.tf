variable "aws_region" {
    default = "us-east-2"
}

variable "vpc_id" {
    default = "vpc-87d13fee"
}

variable "root_volume_size" {
    default = ""
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

variable "host_name" {
    default = "mywintemp"
}

variable "project_name" {
    default = "temp-workstation"  
}