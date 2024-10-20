resource "cloudflare_dns_record" "butt" {
  zone_id = var.cloudflare_zone_id
  name    = "terraform"
  content   = local.my_home_ip
  type    = "A"
  ttl     = 3600
}