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