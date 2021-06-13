#!/bin/bash
yum -y update
yum -y install httpd
sudo service httpd start
sudo bash -c 'echo "Test Server" > /var/www/html/index.html'
chkconfig httpd on