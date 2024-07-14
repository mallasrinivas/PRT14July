provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_instance" "jenkins_master" {
  ami           = "ami-0c2af51e265bd5e0e" # Ubuntu Server 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "awslogin.pem"
  subnet_id     = aws_subnet.main.id
  tags = {
    Name = "JenkinsMaster"
  }
}

resource "aws_instance" "k8s_master" {
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.medium"
  key_name      = "awslogin.pem"
  subnet_id     = aws_subnet.main.id
  tags = {
    Name = "K8sMaster"
  }
}

resource "aws_instance" "k8s_slave" {
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name      = "awslogin.pem"
  subnet_id     = aws_subnet.main.id
  tags = {
    Name = "K8sSlave"
  }
}
