terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  # Credentials are not needed because you logged in via terminal
  # credentials = file("./keys.json")
  project = "de-zoomcamp-2026-484911"
  region  = "us-central1"
}

resource "google_storage_bucket" "data-lake-bucket" {
  # This name must be globally unique across all of Google Cloud
  name          = "de-zoomcamp-2026-484911-terra-bucket"
  location      = "US"

  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  # days
    }
  }

  force_destroy = true
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "zoomcamp_dataset"
  project    = "de-zoomcamp-2026-484911"
  location   = "US"
}