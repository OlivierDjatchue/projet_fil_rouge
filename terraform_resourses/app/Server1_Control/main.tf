provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-derbana"
    key    = "olivierbana-Server1_control.tfstate"
    region = "us-east-1"
  }
}


module "sg" {
  source = "../../modules/sg-modul"
  sg_name = "control_server-sg"
    
}

module "ec2" {
  source = "../../modules/ec2-modul"
  sg_name =  "control_server-sg"
  instance_type = "t2.medium"
  ami= "ami-0a0e5d9c7acc336f1" # ubuntu 
  aws_common_tag ={
   Name ="Server1_Control"
  } 
  user = "ubuntu"
  
  
}

# callng the eip modul
module "eip" {
  source = "../../modules/eip-modul"
  ec2id = module.ec2.ec2_id_out
  
}

# colling the ebs-modul
#module "ebs" {
  #source = "../../modules/ebs-modul"
 # size = "20"
#}

# Joining to Volume to the Instance
#resource "aws_volume_attachment" "ebs_attachment" {
#  device_name = "/dev/sdf"
#  instance_id = module.ec2.ec2_id_out
#  volume_id = module.ebs.volume_id
  
#}

# Association ec2 with eip
resource "aws_eip_association" "aws_eip_association" {
 instance_id = module.ec2.ec2_id_out
  allocation_id = module.eip.allocation_id_out
  
}


resource "null_resource" "name" {
 depends_on = [module.eip]
  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${module.eip.elastic_ip_out} > ip_ec2.txt"
  }
}
