#!/bin/bash
#############################################
# Install Jenkins on Ubuntu, CentOS, Fedora or Arch Linux	
# Author: Djatchue (olivierdja@yahoo.fr)          
# Date: 2024-08-22                                  
# version: 1.0                                       
#############################################


# Function to install Jenkins on Ubuntu/Debian
install_jenkins_ubuntu() {
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
      https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
      https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
      /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins -y
}

# Call the install_jenkins function


# Function to install Jenkins on CentOS/RHEL
       
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        ubuntu|debian)
            echo "Detected Ubuntu/Debian. Installing jenkins..."
           install_jenkins_ubuntu
            ;;
        centos|rhel)
            echo "Detected CentOS/RHEL. Installing jenkins..."
            nstall_jenkins_centos
            ;;
        fedora)
            echo "Detected Fedora. Installing jenkins..."
            install_jenkins_fedora
            ;;
        arch)
            echo "Detected Arch Linux. Installing jenkins..."
            install_jenkins_arch
            ;;
        *)
            echo "Unsupported Linux distribution: $ID"
            exit 1
            ;;
    esac
else
    echo "Cannot detect the Linux distribution."
    exit 1
fi