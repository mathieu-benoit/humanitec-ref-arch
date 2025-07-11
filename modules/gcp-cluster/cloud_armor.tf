locals {
  waf_rules = {
    sqli_rule = {
      priority    = "1000"
      expression  = "evaluatePreconfiguredWaf('sqli-v33-stable', {'sensitivity': 1})"
      description = "Sqli injection"
    }
    xss_rule = {
      priority    = "1100"
      expression  = "evaluatePreconfiguredWaf('xss-v33-stable', {'sensitivity': 1})"
      description = "Cross site scripting"
    }
    lfi_rule = {
      priority    = "1200"
      expression  = "evaluatePreconfiguredWaf('lfi-v33-stable', {'sensitivity': 1})"
      description = "Remote file inclusion"
    }
  }
}

resource "google_compute_security_policy" "external_gateway" {
  name = "${var.cluster_name}-external"

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }

  dynamic "rule" {
    for_each = local.waf_rules
    content {
      action      = "deny(403)"
      priority    = rule.value.priority
      description = rule.value.description
      match {
        expr {
          expression = rule.value.expression
        }
      }
    }
  }

  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }
}