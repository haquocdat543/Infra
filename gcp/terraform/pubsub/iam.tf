resource "google_pubsub_topic_iam_binding" "publisher" {
  topic = google_pubsub_topic.my_topic.name
  role  = "roles/pubsub.publisher"

  members = [
    "serviceAccount:your-service-account@your-project.iam.gserviceaccount.com"
  ]
}

