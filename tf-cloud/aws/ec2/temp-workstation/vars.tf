variable "aws_region" {
    default = "us-east-2"
}

variable "vpc_id" {
    default = "vpc-87d13fee"
}

variable "root_volume_size" {
    default = ""
}

variable "current_ip" {
    default = ""
}

variable "extra_ip" {
    description = "An additional IP to allow in RDP and SSH"
    default = ""
}

variable "instance_type" {
    default = ""
}

variable "instance_key" {
    default = "home-use2"
}

variable "host_name" {
    default = ""
}

variable "project_name" {
    default = "temp-workstation"  
}

variable "new_admin_pw" {
    default = ""
}