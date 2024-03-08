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
    default = "t3.xlarge"
}

variable "instance_key" {
    default = "home-use2"
}

variable "host_name" {
    default = "temp_win_use2"
}

variable "project_name" {
    default = "temp-workstation"  
}

variable "new_admin_pw" {
    default = ""
}