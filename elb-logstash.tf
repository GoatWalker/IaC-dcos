resource "aws_elb" "logstash" {
  /* limit name length to 32 charecters*/
  name = "${replace(var.pre_tag, "/^(.{14}).*/", "$1")}-Logstash-ELB-${replace(var.post_tag, "/^(.{6}).*/", "$1")}"
  subnets = ["${var.public_subnet_id}"]
  security_groups = ["${var.public_security_group_id}"]

  "listener" {
    instance_port = 5044
    instance_protocol = "tcp"
    lb_port            = 80
    lb_protocol        = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "TCP:22"
    interval = 30
  }
}