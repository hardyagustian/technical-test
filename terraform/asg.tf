# Launch Template untuk EC2 instances
resource "aws_launch_template" "payments_tamplate" {
  name          = "payments-launch-template"
  instance_type = "t2.medium"
  image_id      = "ami-0c02fb55956c7d316" # Ganti dengan AMI yang sesuai dengan kebutuhan

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.allow-http-s-prod-vpc.id]
    subnet_id                   = aws_subnet.main-prod-private-subnet-a.id
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Autoscaling Group
resource "aws_autoscaling_group" "asg_payment" {
  launch_template {
    id      = aws_launch_template.payments_tamplate.id
    version = "$Latest"
  }

  min_size         = 2
  max_size         = 5
  desired_capacity = 2

  vpc_zone_identifier = [aws_subnet.main-prod-private-subnet-a.id]

  tag {
    key                 = "Name"
    value               = "payment-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Scaling Policy
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_payment.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_payment.name
}
