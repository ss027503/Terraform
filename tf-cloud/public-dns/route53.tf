locals {
    ss027n4_zone_id = "Z1JB8ESOBEJWFZ"
}

resource "aws_route53_record" "www" {
  zone_id = local.ss027n4_zone_id
  name    = "www.example.com"
  type    = "A"
  ttl     = 300
  records = local.my_home_ip
}