#!/bin/bash
source input



test -f providers.tf && rm providers.tf
test -f css.tf && rm css.tf
test -f data.tf && rm data.tf
test -f outputs.tf && rm outputs.tf

cat >> providers.tf <<EOF
provider "aws" {
  region = "ap-east-1"
  access_key = "$AWS_AK"
  secret_key = "$AWS_SK"
}
EOF

for i in $REGION_LIST
do
cat >> providers.tf <<EOF
provider "aws" {
  alias = "$i" 
  region = "$i"
  access_key = "$AWS_AK"
  secret_key = "$AWS_SK"
}
EOF

cat >> css.tf <<EOF
module "security_group_$i" {
  source  = "../terraform-modules/terraform-aws-security-group/"
  name = "ss-sg"
  providers = {
    aws      = "aws.$i"
  }
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_vpc.$i.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "https-443-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "ec2-test_$i" {
  source = "../terraform-modules/terraform-aws-ec2-instance/"
  providers = {
    aws      = "aws.$i"
  }
  instance_count = 1
  name                        = "www-ss"
  ami                         = data.aws_ami.ubuntu_linux_$i.id
  instance_type               = "c5.large"
  subnet_id                   = tolist(data.aws_subnet_ids.$i.ids)[0]
  #subnet_id                   = sort(data.aws_subnet_ids.default.ids)[0]
  #vpc_security_group_ids      = [data.aws_security_group.default.id]
  vpc_security_group_ids      = [module.security_group_$i.this_security_group_id]
  associate_public_ip_address = true
  user_data = "\${file("ss.sh")}"
}
EOF

cat >> data.tf <<EOF
data "aws_vpc" "$i" {
  default = true
  provider = "aws.$i"
}

data "aws_subnet_ids" "$i" {
  vpc_id = data.aws_vpc.$i.id
  provider = "aws.$i"
}

data "aws_ami" "ubuntu_linux_$i" {
  most_recent = true
  provider = "aws.$i"
  owners = ["099720109477"]

  filter {
    name = "name"

    values = [
      "*/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*",
    ]
  }
}

EOF

cat >> outputs.tf<<EOF
output "public_ip_$i" {
  description = "The IP of the EC2"
  value       = module.ec2-test_$i.public_ip
}
EOF

done


cat > ss.sh <<TOF
#!/bin/bash
sudo apt-get update
sudo apt-get -y install python-pip
sudo pip install shadowsocks

cat >/etc/shadowsocks.json <<EOF
{
        "server":"0.0.0.0",
        "server_port":"443",
        "local_address":"127.0.0.1",
        "local_port":"1024",
        "password":"$SS_PASSWORD",
        "timeout":"300",
        "method":"aes-256-cfb",
        "fast_open": false
}
EOF
sudo ssserver -c /etc/shadowsocks.json -d start


sudo cat > /etc/systemd/system/shadowsocks-server.service <<EOF
[Unit]
Description=Shadowsocks Server
After=network.target

[Service]
ExecStart=/usr/local/bin/ssserver -c /etc/shadowsocks.json
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable shadowsocks-server
TOF

##### terraform 
terraform init
terraform apply -auto-approve




#### crearte config ss json
./export-ss.sh
