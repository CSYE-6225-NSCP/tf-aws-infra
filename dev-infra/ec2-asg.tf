resource "aws_launch_template" "asg_launch_template" {
  name_prefix   = "csye6225_asg_"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.app_sg.id]
  }

  user_data = base64encode(<<-EOT
#!/bin/bash
echo "hello!"
cat <<EOF | sudo tee /opt/webapp/.env
DB_HOST=${aws_db_instance.mysql.address}
DB_PORT=3306
DB_USER=${var.DB_USER}
DB_PASSWORD=${var.DB_PASSWORD}
DB_NAME=${var.DB_NAME}
SERVER_PORT=${var.SERVER_PORT}
DB_DIALECT=${var.DB_DIALECT}
S3_BUCKET_NAME=${aws_s3_bucket.s3_bucket.bucket}
AWS_REGION=${var.aws_region}
DB_LOGGING=false
EOF
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/cloudWatch-config.json -s
EOT
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.aws_region}-asg-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}