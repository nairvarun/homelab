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
        service  = "https://localhost:6443"
        origin_request = {
          no_tls_verify = true
        }
      },
      {
        hostname = "jenkins.nairvarun.com"
        service  = "http://localhost:8866"
        origin_request = {}
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