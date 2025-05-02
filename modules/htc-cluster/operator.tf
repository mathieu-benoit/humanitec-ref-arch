resource "humanitec_key" "operator" {
  count = var.operator_public_key == "" ? 0 : 1
  
  key = var.operator_public_key
}