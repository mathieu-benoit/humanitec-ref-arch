output "cloud_account_gsa_email" {
  value = google_service_account.terraform_provisioner.email
}

output "cloud_account_id" {
  value = google_service_account.terraform_provisioner.account_id
}