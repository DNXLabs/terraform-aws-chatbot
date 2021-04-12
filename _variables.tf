variable "org_name" {
  description = "Name for this organization"
}
variable "workspace_name" {
  description = "Description for the chat integration"
}
variable "enabled" {
  description = "If true, will create aws chatboot and integrate to slack"
  default     = "false"
}
variable "slack_channel_id" {
  description = "Slack channel id to send budget notfication using AWS Chatbot"
  default     = ""
}
variable "slack_workspace_id" {
  description = "Slack workspace id to send budget notfication using AWS Chatbot"
  default     = ""
}
variable "alarm_sns_topic_arns" {
  description = "ARN of SNS Topic(s) to connect to AWS Chatbot"
  # list of string (accept string for backwards compatibility)
  type = any
}


variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
    "Terraform" = true
  }
}