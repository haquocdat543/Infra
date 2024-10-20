locals {

  environment = "prod"
  project     = "vba"
  region      = "ap-southeast-1"
  name        = "ec2-scheduler"
  app         = "start-stop-instances"
  service     = basename(path.cwd)
  name_prefix = "${local.name}-${local.environment}-${local.service}"
  account_id  = data.aws_caller_identity.current.account_id
  json_input  = file("./instances.json")
  json_policy = file("./policy.json")

  tags = {
    App         = local.app
    Service     = local.service
    Region      = local.region
    Project     = local.project
    Environment = local.environment
    Type        = "s3-bucket"
    Terraform   = "true"
  }
}

module "ec2-scheduler" {
  source = "../../../../../modules/eventbridge"

  create_bus         = false
  role_name          = "${local.name_prefix}-${local.environment}-ec2-start-stop-instances"
  attach_policy_json = true
  policy_json        = local.json_policy
  schedules = {
    "ec2-start-instances-${local.environment}" = {
      description         = "Start instances - ${local.environment}"
      schedule_expression = "cron(0 8 ? * * *)"
      timezone            = "Asia/Saigon"
      arn                 = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
      input               = local.json_input
    },
    "ec2-stop-instances-${local.environment}" = {
      description         = "Stop instances - ${local.environment}"
      schedule_expression = "cron(0 21 ? * * *)"
      timezone            = "Asia/Saigon"
      arn                 = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
      input               = local.json_input
    }
  }

  tags = local.tags

}
