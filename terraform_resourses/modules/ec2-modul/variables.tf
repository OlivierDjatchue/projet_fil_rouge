variable "instance_type" {
  type = string
  description = "set aws instance type"
  default = "t2.micro"
  
}
variable "availability_zone" {
  type = string
  description = "set aws availability_zone"
  default = "us-east-1d"
}
variable "user" {
  type = string
  default = "ubuntu"
}



variable "ami" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "aws_common_tag" {
  type        = map(any)
  description = "Set aws tag"
  default = {
    Name = "ec2-mini-projet"
  }

}