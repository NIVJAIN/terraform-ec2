# data "aws_route53_zone" "ecs_domain" {
#   name         = var.domain_name
#   private_zone = false
# }

# data "aws_acm_certificate" "ecs_domain_certificate" {
#   domain      = "*.${var.domain_name}"
#   types       = ["AMAZON_ISSUED"]
#   most_recent = true
# }

resource "aws_route53_record" "ecs_load_balancer_record" {
  for_each = var.hosts2
  name    = "${each.key}.${var.domain_name}"
  type    = "A"
  # zone_id = data.aws_route53_zone.ecs_domain.zone_id
  zone_id = var.zone_id

  alias {
    evaluate_target_health = false
    # name                   = aws_alb.alb.dns_name
    # zone_id                = aws_alb.alb.zone_id
    name                   = var.aws_alb_dnsname
    zone_id                = var.aws_alb_zoneid
  }
}