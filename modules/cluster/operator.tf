resource "tls_private_key" "operator" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "humanitec_key" "operator" {
  key = tls_private_key.operator.public_key_pem
}