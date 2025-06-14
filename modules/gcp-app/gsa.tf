# GSA to provision TF infra
resource "google_service_account" "terraform_provisioner" {
  account_id  = "${var.app_id}-tf-provisioner"
  description = "Account used by Humanitec to provision the Google Cloud infrastructure via Terraform"
}
resource "google_service_account_iam_member" "wi" {
  service_account_id = google_service_account.terraform_provisioner.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${var.gcp_wi_pool_name}/subject/${var.org_id}/${google_service_account.terraform_provisioner.account_id}"
}
resource "google_project_iam_member" "gcs" {
  project = var.gcp_project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.terraform_provisioner.email}"
}
resource "google_project_iam_member" "iammember" {
  project = var.gcp_project_id
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:${google_service_account.terraform_provisioner.email}"
}
resource "google_project_iam_member" "network" {
  project = var.gcp_project_id
  role    = "roles/compute.networkViewer"
  member  = "serviceAccount:${google_service_account.terraform_provisioner.email}"
}
resource "google_project_iam_member" "memorystore_redis" {
  project = var.gcp_project_id
  role    = "roles/redis.admin"
  member  = "serviceAccount:${google_service_account.terraform_provisioner.email}"
}
resource "google_project_iam_member" "apphub" {
  project = var.gcp_project_id
  role    = "roles/apphub.editor"
  member  = "serviceAccount:${google_service_account.terraform_provisioner.email}"
}
resource "google_project_iam_member" "pubsub_topic" {
  project = var.gcp_project_id
  role    = "roles/pubsub.admin"
  member  = "serviceAccount:${google_service_account.terraform_provisioner.email}"
}