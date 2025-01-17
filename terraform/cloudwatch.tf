# CloudWatch Alarm untuk CPU > 45%
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name                = "high-cpu"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 45
  alarm_actions             = [aws_autoscaling_policy.scale_up.arn]
  insufficient_data_actions = []
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_payment.name
  }
}

# CloudWatch Alarm untuk CPU < 20%
resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name                = "low-cpu"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 20
  alarm_actions             = [aws_autoscaling_policy.scale_down.arn]
  insufficient_data_actions = []
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_payment.name
  }
}

# CloudWatch Alarm untuk Status Check Failure
resource "aws_cloudwatch_metric_alarm" "status_check" {
  alarm_name                = "status-check-failure"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Maximum"
  threshold                 = 1
  alarm_actions             = [aws_autoscaling_policy.scale_up.arn]
  insufficient_data_actions = []
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_payment.name
  }
}

# CloudWatch Alarm untuk Network Usage
resource "aws_cloudwatch_metric_alarm" "network_in" {
  alarm_name                = "network-in-high"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 2
  metric_name               = "NetworkIn"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 1000000
  alarm_actions             = [aws_autoscaling_policy.scale_up.arn]
  insufficient_data_actions = []
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_payment.name
  }
}

resource "aws_cloudwatch_metric_alarm" "network_out" {
  alarm_name                = "network-out-high"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 2
  metric_name               = "NetworkOut"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 1000000
  alarm_actions             = [aws_autoscaling_policy.scale_up.arn]
  insufficient_data_actions = []
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_payment.name
  }
}
