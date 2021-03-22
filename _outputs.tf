
output "stack_id" {
  description = "The unique identifier for the stack."
  value       = var.enabled ? aws_cloudformation_stack.tf_chatbot[0].id : ""
}

output "stack_arn" {
  description = "The ARN of the Chatbot Slack configuration"
  value       = var.enabled ?  aws_cloudformation_stack.tf_chatbot[0].outputs.ConfigurationArn : ""
}

output role_name {
  description = "The name of the Chatbot role"
  value       = var.enabled ?  aws_iam_role.chatbot[0].name : ""
}

output role_arn {
  description = "The ARN of the Chatbot role"
  value       = var.enabled ?  aws_iam_role.chatbot[0].arn : ""
}
