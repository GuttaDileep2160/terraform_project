#create launch template for ASG
resource "aws_launch_template" "webapp-launch-template-ASG" {

  name_prefix            = "webapp1"
  image_id               = "ami-062df10d14676e201"
  key_name               = "FirstKeyPair"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_80_22.id]
  user_data              = filebase64("${path.module}/webapp.sh")
}

#create ASG for webapp
resource "aws_autoscaling_group" "webapp-ASG" {
  vpc_zone_identifier = [aws_subnet.project-subnet-1a.id, aws_subnet.project-subnet-1b.id]

  desired_capacity = 2
  max_size         = 2
  min_size         = 2

  launch_template {
    id      = aws_launch_template.webapp-launch-template-ASG.id
    version = "$Latest"
  }
}