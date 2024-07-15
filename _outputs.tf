
output chatbot_role_name {
  description = "The name of the Chatbot role"
  value       = try(awscc_iam_role.chatbot.role_name, "")
}

output chatbot_role_arn {
  description = "The ARN of the Chatbot role"
  value       = try(awscc_iam_role.chatbot.arn, "")
}
