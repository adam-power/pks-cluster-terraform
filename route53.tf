data "aws_route53_zone" "pks_zone" {
  zone_id = "${var.zone_id}"
}

resource "aws_route53_record" "k8s_masters" {
  zone_id = "${data.aws_route53_zone.pks_zone.zone_id}"
  name    = "${var.cluster_name}.${data.aws_route53_zone.pks_zone.name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.k8s_masters.dns_name}"
    zone_id                = "${aws_elb.k8s_masters.zone_id}"
    evaluate_target_health = true
  }
}

