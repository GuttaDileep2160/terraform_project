resource "aws_instance" "backend_server" {
  #ami                   = "ami-062f7200baf2fa504"
  ami                    = var.instance_ami
  key_name               = var.instance_keypair
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.project-private-subnet-1b.id
  vpc_security_group_ids = [aws_security_group.allow-22-for-private-instances.id]

  tags = {
    Name  = "terraform provided ec2 backend server"
    App   = "backend"
    Owner = "dileep"
  }
}

resource "aws_instance" "jump_server" {
  #ami                   = "ami-062f7200baf2fa504"
  ami                    = var.instance_ami
  key_name               = var.instance_keypair
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.project-subnet-1b.id
  vpc_security_group_ids = [aws_security_group.allow_80_22.id]

  tags = {
    Name  = "terraform provided ec2 Jump Server"
    App   = "Jump Server"
    Owner = "dileep"
  }
}