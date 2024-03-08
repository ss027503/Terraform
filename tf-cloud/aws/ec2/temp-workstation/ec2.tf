resource "aws_instance" "this" {
    ami                     = data.aws_ami.win2022.id
    instance_type           = var.instance_type
    vpc_security_group_ids  = [module.aws_security_group.security_group_id]
    subnet_id               = data.aws_subnet.use2a.id
    key_name                = var.instance_key

    user_data = <<-EOF
		<powershell>
        Set-ExecutionPolicy -ExecutionPolicy unrestricted
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Rename-Computer -NewName "${var.host_name}" -Force

        $SecureString = ConvertTo-SecureString -String "${var.new_admin_pw}" -AsPlainText -Force
        $UserAccount = Get-LocalUser -Name "Administrator"
        $UserAccount | Set-LocalUser -Password $SecureString

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