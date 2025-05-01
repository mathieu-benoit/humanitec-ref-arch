output "service_users_tokens" {
  value     = humanitec_service_user_token.service_user
  sensitive = true
}