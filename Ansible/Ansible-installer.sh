#!/bin/bash
    sudo yum update -y                 # For Amazon Linux 2
    sudo amazon-linux-extras install ansible2 -y
    echo "Ansible installed" >> /tmp/ansible-installation.log