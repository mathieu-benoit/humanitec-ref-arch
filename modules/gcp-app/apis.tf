resource "google_project_service" "gsm" {
  project = var.gcp_project_id
  service = "secretmanager.googleapis.com"
}

resource "google_project_service" "memorystore" {
  project = var.gcp_project_id
  service = "memorystore.googleapis.com"
}