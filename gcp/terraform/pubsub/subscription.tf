resource "google_pubsub_subscription" "my_subscription" {
  name  = "my-subscription"
  topic = google_pubsub_topic.my_topic.id

  ack_deadline_seconds = 20

  # Optional push config (comment this out for pull subscriptions)
  # push_config {
  #   push_endpoint = "https://your-endpoint.com/push"
  # }

  # Optional message retention
  message_retention_duration = "604800s" # 7 days
}
