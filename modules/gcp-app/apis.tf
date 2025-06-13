resource "google_project_service" "gsm" {
  project = var.gcp_project_id
  service = "secretmanager.googleapis.com"
}

resource "google_project_service" "memorystore_redis" {
  project = var.gcp_project_id
  service = "redis.googleapis.com"
}