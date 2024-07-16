
resource "awscc_chatbot_slack_channel_configuration" "slack" {
  for_each = {for config in var.slack_targets : config.slack_channel_name => config}

  configuration_name = "slack-config-${each.value.slack_channel_name}"
  iam_role_arn       = awscc_iam_role.chatbot.arn
  slack_channel_id   = each.value.slack_channel_id
  slack_workspace_id = each.value.slack_workspace_id
  sns_topic_arns     = [aws_sns_topic.chatbot[each.value.slack_channel_name].arn] #var.alarm_sns_topic_arns
  logging_level      = try(each.value.logging_level, "NONE")
}

resource "awscc_chatbot_microsoft_teams_channel_configuration" "microsoft" {
  for_each = {for config in var.teams_targets : config.teams_channel_name => config}

  configuration_name = "teams-config-${each.value.teams_channel_name}"
  iam_role_arn       = awscc_iam_role.chatbot.arn
  team_id            = each.value.team_id
  teams_channel_id   = each.value.teams_channel_id
  teams_tenant_id    = each.value.teams_tenant_id
  sns_topic_arns     = [aws_sns_topic.chatbot[each.value.teams_channel_name].arn]
  logging_level      = try(each.value.logging_level, "NONE")
}

resource "awscc_iam_role" "chatbot" {
  role_name = "chatBot-integration-role"
  assume_role_policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "chatbot.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSResourceExplorerReadOnlyAccess", "arn:aws:iam::aws:policy/CloudWatchEventsReadOnlyAccess", "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"]
}