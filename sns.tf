resource "aws_sns_topic" "chatbot" {
  for_each = {for config in var.slack_targets : config.slack_channel_name => config}

  name              = "chatbot-${each.value.slack_channel_name}"
#   kms_master_key_id = var.kms_key  default key does not allow cloudwatch alarms to publish
  tags              = var.tags
}

resource "aws_sns_topic_policy" "alarms" {
  for_each = {for config in var.slack_targets : config.slack_channel_name => config}
  arn    = aws_sns_topic.chatbot[each.value.slack_channel_name].arn
  policy = data.aws_iam_policy_document.alarms_policy[each.value.slack_channel_name].json
}

data "aws_iam_policy_document" "alarms_policy" {
  for_each = {for config in var.slack_targets : config.slack_channel_name => config}

  policy_id = "allow-org-accounts"


  statement {
    actions = ["sns:Publish"]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = [ "cloudwatch.amazonaws.com","events.amazonaws.com"]
    }
    resources = [aws_sns_topic.chatbot[each.value.slack_channel_name].arn]
    sid       = "allow-cloudwatch-events"
  }

  statement {
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
    ]
    effect = "Allow"
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = var.account_ids
    }
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [aws_sns_topic.chatbot[each.value.slack_channel_name].arn]
    sid       = "allow-org-accounts"
  }
}