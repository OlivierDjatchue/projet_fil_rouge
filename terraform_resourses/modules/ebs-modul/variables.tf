variable "availability_zone" {
  description = "The availability zone where the EBS volume will be created"
  type        = string
  default = "us-east-1d"
}

variable "size" {
  description = "The size of the EBS volume in GiB"
  type        = number
}


