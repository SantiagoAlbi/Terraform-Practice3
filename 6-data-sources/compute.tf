data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] #owner is Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }



}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
  value = data.aws_region.current
}


resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  #subnet_id                   = aws_subnet.public.id
  #vpc_security_group_ids      = [aws_security_group.public_http_traffic.id]


  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }
}