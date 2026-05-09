variable "bucket_name" {
  type = string
}

variable "location" {
  type    = string
  default = "US"
}

# INSECURE BUCKET (Checkov flags)
resource "google_storage_bucket" "app_bucket" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = true

  # CHECKOV FLAG: Uniform bucket-level access not enforced
  uniform_bucket_level_access = false

  # CHECKOV FLAG: Versioning disabled
  versioning {
    enabled = false
  }

  # CHECKOV FLAG: No logging configured
  # CHECKOV FLAG: No encryption with CMEK
}

# CHECKOV FLAG: Public access to bucket!
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.app_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

output "bucket_name" {
  value = google_storage_bucket.app_bucket.name
}
