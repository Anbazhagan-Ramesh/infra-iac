terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "mock-demo-project-12345"
  region  = "us-central1"
  # Credentials supplied via GOOGLE_CREDENTIALS env var in CI (generated mock key)
  # No real GCP account needed — terraform plan -refresh=false skips all API calls
}

# ============================================
# 1. EXPENSIVE VM (Infracost will flag high cost)
# Also has security flaws (Checkov will flag)
# ============================================
resource "google_compute_instance" "web_server" {
  name         = "demo-web-server"
  machine_type = "n1-standard-8"   # Expensive! ~$200/month
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 500                    # Large disk = more cost
      type  = "pd-ssd"               # SSD = more cost
    }
  }

  network_interface {
    network = "default"
    access_config {
      # CHECKOV FLAG: Public IP assigned (no static IP block)
    }
  }

  # CHECKOV FLAG: Shielded VM not enabled
  # CHECKOV FLAG: OS Login not enabled
  metadata = {
    enable-oslogin = "FALSE"
  }

  service_account {
    scopes = ["cloud-platform"]      # CHECKOV FLAG: Full access scope
  }
}

# ============================================
# 2. EXPENSIVE SQL DATABASE (Infracost flag)
# ============================================
resource "google_sql_database_instance" "main_db" {
  name             = "demo-database"
  database_version = "POSTGRES_14"
  region           = "us-central1"

  settings {
    tier = "db-n1-standard-4"        # Expensive tier

    ip_configuration {
      ipv4_enabled = true            # CHECKOV FLAG: Public IP enabled
      authorized_networks {
        name  = "all"
        value = "0.0.0.0/0"          # CHECKOV FLAG: Open to the world!
      }
    }

    backup_configuration {
      enabled = false                # CHECKOV FLAG: Backups disabled
    }
  }

  deletion_protection = false
}

# ============================================
# 3. INSECURE FIREWALL (Checkov flag)
# ============================================
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-from-anywhere"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["0.0.0.0/0"]      # CHECKOV FLAG: SSH open to world!
}

# ============================================
# 4. STORAGE MODULE (For Rover visualization)
# ============================================
module "app_storage" {
  source      = "./modules/storage"
  bucket_name = "demo-app-bucket-meetup"
  location    = "US"
}
