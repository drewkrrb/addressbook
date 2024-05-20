#!/bin/bash

# Add user 'test'
useradd -m -s /bin/bash test

# Set password for user 'test'
echo 'test:helloworld' | chpasswd

# Add 'test' to the sudoers file
echo 'test ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
echo 'ec2-user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Allow password authentication in SSH
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
# Restart SSH service to apply changes
systemctl restart sshd

sudo dnf update
sudo dnf install java
sudo dnf -y install wget
wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.23/bin/apache-tomcat-10.0.23.tar.gz

tar -xvf apache-tomcat-10*.tar.gz
mv apache-tomcat-10.0.23 /home/ec2-user/tomcat

chown ec2-user:ec2-user -R /home/ec2-user/tomcat
