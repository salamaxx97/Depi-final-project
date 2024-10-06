provider "aws" {
  region  = var.region         
  profile = var.aws_profile    
}

# Define the security group for Jenkins server
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow SSH and Jenkins ports"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Jenkins (port 8080)"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ssh_key" {
  source   = "./KeyPair"
  key_name = var.key_name
}

# Create EC2 instance for Jenkins
resource "aws_instance" "jenkins_server" {
  ami             = var.ami_id           
  instance_type   = var.instance_type    
  key_name        = var.key_name         

  security_groups = [aws_security_group.jenkins_sg.name]

  tags = {
    Name = "JenkinsServer"
  }
}

# Output the public IP of the Jenkins instance
output "jenkins_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}
