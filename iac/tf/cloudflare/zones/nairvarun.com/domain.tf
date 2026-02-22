resource "cloudflare_zone" "nairvarun_com" {
  name                = "nairvarun.com"
  paused              = false
  type                = "full"
  account = {
    id = local.account_id
  }
}
