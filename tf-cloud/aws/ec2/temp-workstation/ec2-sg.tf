locals {
    set_ips = [
        var.current_ip,
        var.extra_ip
    ]
}

module "aws_security_group" {
    source = "terraform-aws-modules/security-group/aws"
    version = "~> 5.0"
    name = "${var.host_name}-sg"
    description = "does this matter?"
    vpc_id = var.vpc_id
    ingress_with_cidr_blocks = [
        {
            rule = "rdp-tcp"
            description = "rdp"
            cidr_blocks = join(",", local.set_ips)
        },
        {
            rule = "ssh-tcp"
            description = "ssh"
            cidr_blocks = join(",", local.set_ips)
        }
    ]
}
