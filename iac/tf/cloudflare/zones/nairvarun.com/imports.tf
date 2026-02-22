# zone
import {
  to = cloudflare_zone.nairvarun_com
  id = "6074b79893bfc97386c84e44263b4ab3"
}

# dns
import {
  to = cloudflare_dns_record.example_a
  id = "6074b79893bfc97386c84e44263b4ab3/0bfbc7d12be9e3441e8998a674537342"
}

import {
  to = cloudflare_dns_record.root_a
  id = "6074b79893bfc97386c84e44263b4ab3/2f52f07886e0f66b5f4cf1cf8812818c"
}

import {
  to = cloudflare_dns_record.jenkins_cname
  id = "6074b79893bfc97386c84e44263b4ab3/8ac582610747d9e35e19cb2179fc43ad"
}

import {
  to = cloudflare_dns_record.k8s_cname
  id = "6074b79893bfc97386c84e44263b4ab3/4e785f1640183e0e853d10cde153ebb5"
}

import {
  to = cloudflare_dns_record.wildcard_cname
  id = "6074b79893bfc97386c84e44263b4ab3/c1601ee2d4d5658a2d566567da8f8db7"
}

import {
  to = cloudflare_dns_record.www_cname
  id = "6074b79893bfc97386c84e44263b4ab3/a81f20c20d2834c22f89629cbce071d1"
}

# redirect rules
import {
  to = cloudflare_ruleset.redirect_rules
  id = "zones/6074b79893bfc97386c84e44263b4ab3/79c91851b3fd42f0983f6bf53a4323b3"
}
