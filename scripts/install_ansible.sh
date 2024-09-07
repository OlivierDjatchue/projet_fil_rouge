#!/bin/bash
#############################################
# Install Ansible on Ubuntu, CentOS, Fedora #
# Author: Djatchue (olivierdja@yahoo.fr)          #
# Date: 2024-08-22                                  #
# version: 1.0                                       #
#############################################

# Check the Linux distribution
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    if [[ $ID == "ubuntu" ]]; then
        # Install Ansible on Ubuntu
        sudo apt-get update
        sudo apt-get install -y ansible
    elif [[ $ID == "centos" ]]; then
        # Install Ansible on CentOS
        sudo yum install -y epel-release
        sudo yum install -y ansible
    elif [[ $ID == "fedora" ]]; then
        # Install Ansible on Fedora
        sudo dnf install -y ansible
    else
        echo "Unsupported Linux distribution: $ID"
        exit 1
    fi
else
    echo "Unable to determine the Linux distribution"
    exit 1
fi