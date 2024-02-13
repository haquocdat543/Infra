resource "google_service_account" "test_sa" {
  account_id   = "my-custom-sa"
  display_name = "Custom SA for VM Instance"
}
