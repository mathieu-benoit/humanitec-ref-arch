resource "humanitec_secretstore" "enable_operator_mode" {
  id      = "enable-operator-mode"
  primary = true
  gcpsm = {
    project_id = "enable-operator-mode"
  }
}