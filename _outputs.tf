
output "slack_arns" {
  description = "A map of the Chatbot Slack configurations ARNs"
  value       = local.slack_arns
}

output "role_name" {
  description = "The name of the Chatbot role"
  value       = var.enabled ? aws_iam_role.chatbot[0].name : ""
}

output "role_arn" {
  description = "The ARN of the Chatbot role"
  value       = var.enabled ? aws_iam_role.chatbot[0].arn : ""
}
