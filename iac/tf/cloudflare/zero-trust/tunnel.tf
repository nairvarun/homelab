locals {
  yoga_ip = "192.168.0.11"
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "yoga" {
  account_id = local.account_id
  name       = "yoga"
  config_src = "cloudflare"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "yoga" {
  account_id = local.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.yoga.id

  config = {
    ingress = [
      {
        hostname = "yoga.nairvarun.com"
        service  = "ssh://${local.yoga_ip}:22"
        origin_request = {
          no_tls_verify = true
        }
      },
      {
        service = "http_status:404"
      }
    ]
  }
}
