/* For SecretStore */
resource "google_project_service" "gsm" {
  project = var.gcp_project_id
  service = "secretmanager.googleapis.com"
}

/* For assigning IAM member in WI graph */

resource "google_project_service" "cloudresourcemanager" {
  project = var.gcp_project_id
  service = "cloudresourcemanager.googleapis.com"
}

/* For resource types supported for the Devs */

resource "google_project_service" "memorystore_redis" {
  project = var.gcp_project_id
  service = "redis.googleapis.com"
}

resource "google_project_service" "vertex_ai" {
  project = var.gcp_project_id
  service = "aiplatform.googleapis.com"
}