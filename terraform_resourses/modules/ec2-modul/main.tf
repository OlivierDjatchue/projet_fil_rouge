

resource "aws_instance" "my_ec2" {
    ami = var.ami
    instance_type =   var.instance_type
    key_name = "terraformkey"
    security_groups = [ "${var.sg_name}" ]
    tags = var.aws_common_tag
    availability_zone = var.availability_zone
    
    
    root_block_device {
        delete_on_termination = true
        
        volume_size = 20
    }

    connection {
     type = "ssh"
     user = var.user
     private_key = file("${path.module}/terraformkey.pem")
     host = self.public_ip
    }
    provisioner "file" {
    source      = "../../../scripts/install_docker.sh"
    destination = "/tmp/install_docker.sh"
    }
    provisioner "file" {
    source      = "../../../scripts/install_jenkins.sh"
    destination = "/tmp/install_jenkins.sh"
    }

    provisioner "file" {
    source      = "../../../scripts/install_ansible.sh"
    destination = "/tmp/install_ansible.sh"
    }

    
   provisioner "remote-exec" {
    
    inline = [
      "chmod +x /tmp/install_docker.sh",
    
      "/tmp/install_docker.sh",
      "sudo usermod -aG docker $USER",
     # "sudo curl -L 'https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose",
     # "sudo chmod +x /usr/local/bin/docker-compose"
     # "chmod +x /tmp/install_jenkins.sh",
      #"/tmp/install_jenkins.sh",
      #"chmod +x /tmp/install_ansible.sh",
      #"/tmp/install_ansible.sh"

      
      # install minikube and kubectl
     #"curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb",
      #"sudo dpkg -i minikube_latest_amd64.deb",
     # "curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl",
     ## "chmod +x ./kubectl",
     # "sudo mv ./kubectl /usr/local/bin/kubectl"

       
    ]
  
  }
  
}
