#!bin/bash
sudo amazon-linux-extras install epel -y
sudo yum install -y ansible 
sudo curl -o /tmp/terraform.zip  https://releases.hashicorp.com/terraform/0.12.10/terraform_0.12.10_linux_amd64.zip
sudo curl -o /tmp/packer.zip https://releases.hashicorp.com/packer/1.4.4/packer_1.4.4_linux_amd64.zip
sudo unzip /tmp/terraform.zip -d /usr/local/bin
sudo unzip /tmp/packer.zip -d /usr/local/bin
