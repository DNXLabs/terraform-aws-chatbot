
locals {

  primary_name = "${var.org_name}-${var.workspace_name}"

  primary_target = (var.slack_channel_id != "" && var.slack_workspace_id != "") ? {
    (local.primary_name) = {
      channel   = var.slack_channel_id
      workspace = var.slack_workspace_id
  } } : {}

  # Priority to primary target if names conflict

  slack_targets = merge(var.slack_ids, local.primary_target)

  # Outputs

  stacks     = (var.enabled ? aws_cloudformation_stack.tf_chatbot : {})
  slack_arns = { for k, v in local.stacks : k => v.outputs.ConfigurationArn }
}

# For debugging only
#output stacks { value = local.stacks }
