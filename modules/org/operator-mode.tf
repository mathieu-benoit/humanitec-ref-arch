resource "humanitec_secretstore" "enable_operator_mode" {
  id      = "enable-operator-mode"
  primary = true
  awssm = {
    region = "enable-operator-mode"
  }
}