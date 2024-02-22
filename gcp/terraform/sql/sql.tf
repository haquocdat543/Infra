resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "POSTGRES_15"
  region           = var.region
  deletion_protection = false

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
}
