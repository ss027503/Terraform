resource "aws_security_group" "this" {
    name            = "connect-from-home-sg"
    vpc_id          = var.vpc_id

    ingress {
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        cidr_blocks = join(["${var.home_ip}/32", "${var.extra_ip}/32"])      
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = join(["${var.home_ip}/32", "${var.extra_ip}/32"])        
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "aws_security_group" {
    source = "terraform-aws-modules/security-group/aws"
    version = "~> 3.0"
    name = "${var.host_name}-sg"
    description = "does this matter?"
    vpc_id = var.vpc_id
    ingress_with_cidr_blocks = [
        {
            rule = "rdp-tcp"
            description = "rdp"
            cidr_blocks = join(",", var.home_ip, var.extra_ip)
        },
        {
            rule = "ssh-tcp"
            description = "ssh"
            cidr_blocks = join(",", var.home_ip, var.extra_ip)
        }
    ]
}