variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "elastic_ip_name" {
  description = "Name tag for the Elastic IP"
  type        = string
  default     = "my-elastic-ip"
}

variable "availability_zone" {
  description = "The availability zone where the EBS volume will be created"
  type        = string
  default     = "us-west-2a"
}

variable "ebs_size" {
  description = "The size of the EBS volume in GiB"
  type        = number
  default     = 10
}

variable "ebs_name" {
  description = "Name tag for the EBS volume"
  type        = string
  default     = "my-ebs-volume"
}

variable "username" {
  type        = string
  default     = "Server2_Client_2"

}

