resource "aws_instance" "web_app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = element(aws_subnet.public[*].id, 0) 
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  disable_api_termination = false

  tags = {
    Name = "WebAppInstance"
  }
}