#! /bin/bash
#########################################
# Author: Djatchue
# Date: 20.08.2024
# Version:001
# Description: Installing Docker in all linux distributions#

##########################################

set -x  # run the script in debug mode
set -o pipefail

# Add Docker's official GPG key:
install_docker_debian(){

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

}

# Function to install Docker on CentOS/RHEL
install_docker_centos() {
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
     # Add the current user to the docker group
    sudo usermod -aG docker $USER
    # Insatlling docker-compose
    curl -L https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    chmod 775 /usr/local/bin/docker-compose
    docker-compose --version

}

# Function to install Docker on Fedora
install_docker_fedora() {
    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
    # Insatlling docker-compose
    
}

# Function to install Docker on Arch Linux
install_docker_arch() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm docker
    sudo systemctl start docker
    sudo systemctl enable docker
}

if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        ubuntu|debian)
            echo "Detected Ubuntu/Debian. Installing Docker..."
            install_docker_debian
            ;;
        centos|rhel)
            echo "Detected CentOS/RHEL. Installing Docker..."
            install_docker_centos
            ;;
        fedora)
            echo "Detected Fedora. Installing Docker..."
            install_docker_fedora
            ;;
        arch)
            echo "Detected Arch Linux. Installing Docker..."
            install_docker_arch
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

# Verify Docker installation
docker --version
if [ $? -eq 0 ]; then
    echo "Docker installation was successful."
else
    echo "Docker installation failed."
    exit 1
fi
