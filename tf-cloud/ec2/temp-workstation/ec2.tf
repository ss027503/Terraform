resource "aws_instance" "this" {
    ami                     = data.aws_ami.win2022.id
    instance_type           = var.instance_type
    vpc_security_group_ids  = [aws_security_group.this.id]
    subnet_id               = data.aws_subnet.use2a
    key_name                = var.instance_key

    user_data = <<-EOF
		<powershell>
        Set-ExecutionPolicy -ExecutionPolicy unrestricted
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Rename-Computer -NewName "${var.host_name}" -Force
        Set-TimeZone -Name "Central Standard Time"
        choco install -y firefox putty winscp 7zip notepadplusplus vlc sumatrapdf pia
        
        Restart-Computer -Force
        </powershell>
	EOF

    root_block_device {
        delete_on_termination   = true
        encrypted               = false
        volume_type             = "gp3"
        volume_size             = var.root_volume_size
    }
    
    tags = {
        Name                = var.host_name
    }
}

resource "aws_security_group" "this" {
    name            = "connect-from-home-sg"
    vpc_id          = var.vpc_id

    ingress {
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        cidr_blocks = ["${var.home_ip}/32"]        
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.home_ip}/32"]        
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}