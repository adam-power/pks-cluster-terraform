resource "aws_route53_record" "k8s_masters" {
  zone_id = "${var.zone_id}"
  name    = "${var.cluster_external_dns}"
  type    = "A"

  alias {
    name                   = "${aws_elb.k8s_masters.dns_name}"
    zone_id                = "${aws_elb.k8s_masters.zone_id}"
    evaluate_target_health = true
  }
}

