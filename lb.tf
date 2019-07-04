resource "aws_elb" "k8s_masters" {
  name = "k8s-master-${var.cluster_name}"

  subnets = "${var.subnet_ids}"

  security_groups = ["${var.master_security_group}"]

  listener {
    instance_port     = 8443
    instance_protocol = "tcp"
    lb_port           = 8443
    lb_protocol       = "tcp"
  }

  health_check {
    target = "tcp:8443"
    timeout = 5
    interval = 30
    unhealthy_threshold = 2
    healthy_threshold = 10
  }

  instances = "${var.master_ids}"
}
