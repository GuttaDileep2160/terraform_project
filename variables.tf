variable "instance_ami" {
  description = "Value of the image to be used for instance"
  type        = string
  default     = "ami-062df10d14676e201"
}

variable "instance_keypair" {
  description = "Value of the key pair to be used"
  type        = string
  default     = "FirstKeyPair"
}

variable "instance_type" {
  description = "Value of the ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "load_balancer_type" {
  description = "Value of the LB type"
  type        = string
  default     = "application"
}

variable "aws_region" {
  description = "Value of the LB type"
  type        = string
  default     = "ap-south-1"
}