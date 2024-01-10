# Create a new endpoint
resource "aws_dms_endpoint" "source" {
  database_name               = "test"
  endpoint_id                 = "test-dms-source-endpoint-tf"
  endpoint_type               = "source"
  engine_name                 = "aurora"
  extra_connection_attributes = ""
  username                    = "haquocdat"
  password                    = "haquocdat"
  port                        = 3306
  server_name                 = "test"
  ssl_mode                    = "none"

  tags = {
    Name = "Source"
    Env  = "Dev"
  }

}

# Create a new endpoint
resource "aws_dms_endpoint" "target" {
  database_name               = "test"
  endpoint_id                 = "test-dms-target-endpoint-tf"
  endpoint_type               = "target"
  engine_name                 = "aurora"
  extra_connection_attributes = ""
  username                    = "haquocdat"
  password                    = "haquocdat"
  port                        = 3306
  server_name                 = "test"
  ssl_mode                    = "none"

  tags = {
    Name = "Target"
    Env  = "Dev"
  }

}
