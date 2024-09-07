#! /bin/bash
#########################################
# Author: Djatchue
# Date: 20.08.2024
# Version:001
# Description: Installing Docker in all linux distributions#

##########################################

set -x  # run the script in debug mode
set -o pipefail

# Function to install minikube on Debian/Ubuntu
install_minikube_debian(){
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    minikube version

}

#  Function to install minikube on CentOS/RHEL
install_minikube_centos() {
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    minikube version
}

# Function to install Docker on Fedora
install_minikube_fedora() {
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    minikube version
}

# Function to install Docker on Arch Linux
install_minikube_arch() {
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    minikube version
}

if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        ubuntu|debian)
            echo "Detected Ubuntu/Debian. Installing Installing minikube..."
            install_minikube_debian
            ;;
        centos|rhel)
            echo "Detected CentOS/RHEL. Installing Installing minikube.."
            install_minikube_centos
            ;;
        fedora)
            echo "Detected Fedora. Installing Installing minikube..."
            install_minikube_fedora
            ;;
        arch)
            echo "Detected Arch Linux. Installing Installing minikube..."
            install_minikube_arch
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

# Verify minikube installation

