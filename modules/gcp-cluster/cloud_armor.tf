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
      description = "Local file inclusion"
    }
    rfi_rule = {
      priority    = "1300"
      expression  = "evaluatePreconfiguredWaf('rfi-v33-stable', {'sensitivity': 1})"
      description = "Remote file inclusion"
    }
    rce_rule = {
      priority    = "1400"
      expression  = "evaluatePreconfiguredWaf('rce-v33-stable', {'sensitivity': 1})"
      description = "Remote code execution"
    }
    methodenforcement_rule = {
      priority    = "1500"
      expression  = "evaluatePreconfiguredWaf('methodenforcement-v33-stable', {'sensitivity': 1})"
      description = "Method enforcement"
    }
    scannerdetection_rule = {
      priority    = "1600"
      expression  = "evaluatePreconfiguredWaf('scannerdetection-v33-stable', {'sensitivity': 1})"
      description = "Scanner detection"
    }
    protocolattack_rule = {
      priority    = "1700"
      expression  = "evaluatePreconfiguredWaf('protocolattack-v33-stable', {'sensitivity': 1})"
      description = "Protocol attack"
    }
    php_rule = {
      priority    = "1800"
      expression  = "evaluatePreconfiguredWaf('php-v33-stable', {'sensitivity': 1})"
      description = "PHP injection attack"
    }
    sessionfixation_rule = {
      priority    = "1900"
      expression  = "evaluatePreconfiguredWaf('sessionfixation-v33-stable', {'sensitivity': 1})"
      description = "Session fixation attack"
    }
    java_rule = {
      priority    = "2000"
      expression  = "evaluatePreconfiguredWaf('java-v33-stable', {'sensitivity': 1})"
      description = "Java attack"
    }
    nodejs_rule = {
      priority    = "2100"
      expression  = "evaluatePreconfiguredWaf('nodejs-v33-stable', {'sensitivity': 1})"
      description = "NodeJS attack"
    }
    cve_rule = {
      priority    = "2200"
      expression  = "evaluatePreconfiguredExpr('cve-canary')"
      description = "Log4j vulnerability"
    }
    json_sqli_rule = {
      priority    = "2300"
      expression  = "evaluatePreconfiguredExpr('json-sqli-canary')"
      description = "JSON-based SQL injection bypass vulnerability"
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

  advanced_options_config {
    log_level = "VERBOSE"
  }
}