resource "aws_lb" "ALB" {
  load_balancer_type = "application"
  security_groups    = [aws_security_group.pub_sec.id]
  tags = {
    Environment = "ALB"
  }
    subnet_mapping {
    subnet_id     = aws_subnet.pubnet1.id

  }
   subnet_mapping {
    subnet_id     = aws_subnet.pubnet2.id

  }
}  
#target group
resource "aws_lb_target_group" "ALB_target" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
}
#listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ALB_target.arn
  }
}
resource "aws_lb_target_group_attachment" "targetinstance1" {
  target_group_arn = aws_lb_target_group.ALB_target.arn
  target_id        = aws_instance.web-1.id
}
resource "aws_lb_target_group_attachment" "targetinstance2" {
  target_group_arn = aws_lb_target_group.ALB_target.arn
  target_id        = aws_instance.web-2.id
}