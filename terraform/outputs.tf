output "vm_name" {
  value = google_compute_instance.web_server.name
}

output "db_name" {
  value = google_sql_database_instance.main_db.name
}

output "bucket_name" {
  value = module.app_storage.bucket_name
}
