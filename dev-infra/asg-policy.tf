resource "aws_autoscaling_group" "web_app_asg" {
  name                = "csye6225_asg"
  min_size            = 3
  max_size            = 5
  desired_capacity    = 3
  health_check_type   = "ELB"
  vpc_zone_identifier = aws_subnet.public[*].id
  target_group_arns   = [aws_lb_target_group.web_app_tg.arn]

  launch_template {
    id      = aws_launch_template.asg_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "web-app-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.web_app_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.web_app_asg.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 5
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  dimensions          = { AutoScalingGroupName = aws_autoscaling_group.web_app_asg.name }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low-cpu-utilization"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 4
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  dimensions          = { AutoScalingGroupName = aws_autoscaling_group.web_app_asg.name }
}