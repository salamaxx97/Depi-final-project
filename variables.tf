variable "region" {
  description = "The AWS region to deploy the Jenkins server"
  type        = string
  default     = "us-east-1"  
}

variable "aws_profile" {
  description = "The AWS CLI profile to use for authentication"
  type        = string
  default     = "default"    
}

variable "ami_id" {
  description = "The AMI ID for the Jenkins server"
  type        = string
  default     = "ami-0dc2d3e4c0f9ebd18"  # Default to Ubuntu 20.04 LTS AMI
}

variable "instance_type" {
  description = "The instance type for the Jenkins server"
  type        = string
  default     = "t2.micro"  
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the Jenkins server"
  type        = string
}
