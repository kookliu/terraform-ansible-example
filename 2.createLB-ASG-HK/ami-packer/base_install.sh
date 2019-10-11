#!/bin/bash

sudo pkill yum 
sudo yum install -y httpd php 
sudo amazon-linux-extras install epel -y
sudo yum install -y stress 

sudo systemctl enable httpd

sudo tar zxvf /tmp/burn.tgz -C /var/www/html/


