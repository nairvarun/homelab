locals {
  yoga_ip = "192.168.0.2"
  sus_ip  = "192.168.0.7"
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
        hostname = "k8s.nairvarun.com"
        service  = "https://${local.yoga_ip}:6443"
        origin_request = {
          no_tls_verify = true
        }
      },
      {
        hostname = "sus.nairvarun.com"
        service  = "ssh://${local.sus_ip}:22"
        origin_request = {
          no_tls_verify = true
        }
      },
      {
        hostname = "yoga.nairvarun.com"
        service  = "ssh://${local.yoga_ip}:22"
        origin_request = {
          no_tls_verify = true
        }
      },
      {
        hostname = "*.nairvarun.com"
        service  = "http://localhost:80"
        origin_request = {}
      },
      {
        service = "http_status:404"
      }
    ]
  }
}
