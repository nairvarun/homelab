resource "cloudflare_dns_record" "example_a" {
  zone_id = local.zone_id
  name    = "example"
  type    = "A"
  content = "192.0.2.1"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "root_a" {
  zone_id = local.zone_id
  name    = "@"
  type    = "A"
  content = "192.0.2.1"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "wildcard_cname" {
  zone_id = local.zone_id
  name    = "*"
  type    = "CNAME"
  content = "${local.tunnel_id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "www_cname" {
  zone_id = local.zone_id
  name    = "www"
  type    = "CNAME"
  content = "nairvarun.github.io"
  proxied = true
  ttl     = 1
}
