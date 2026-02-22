resource "cloudflare_ruleset" "redirect_rules" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_dynamic_redirect"
  zone_id = data.cloudflare_zone.nairvarun_com.id
  rules = [
    {
      action = "redirect"
      action_parameters = {
        from_value = {
          preserve_query_string = true
          status_code           = 301
          target_url = {
            expression = "wildcard_replace(http.request.full_uri, r\"https://example.nairvarun.com/*\", r\"https://example.com/$${1}\")"
          }
        }
      }
      description  = "example.nairvarun.com --> example.com"
      enabled      = true
      expression   = "(http.request.full_uri wildcard r\"http://example.nairvarun.com/*\") or (http.request.full_uri wildcard r\"https://example.nairvarun.com/*\")"
    },
    {
      action = "redirect"
      action_parameters = {
        from_value = {
          preserve_query_string = true
          status_code           = 301
          target_url = {
            expression = "wildcard_replace(http.request.full_uri, r\"https://nairvarun.com/*\", r\"https://www.nairvarun.com/$${1}\")"
          }
        }
      }
      description  = "Redirect from Root to WWW [Template]"
      enabled      = true
      expression   = "(http.request.full_uri wildcard r\"https://nairvarun.com/*\")"
    },
    {
      action = "redirect"
      action_parameters = {
        from_value = {
          preserve_query_string = true
          status_code           = 301
          target_url = {
            expression = "wildcard_replace(http.request.full_uri, r\"http://*\", r\"https://$${1}\")"
          }
        }
      }
      description  = "Redirect from HTTP to HTTPS [Template]"
      enabled      = true
      expression   = "(http.request.full_uri wildcard r\"http://*\")"
    }
  ]
}
