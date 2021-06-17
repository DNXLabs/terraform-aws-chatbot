
# Note that the same configuration name cannot appear more than once, even in different slack
# workspaces.

resource "aws_cloudformation_stack" "tf_chatbot" {
  for_each = var.enabled ? local.slack_targets : {}

  name = "terraform-chatbot-${each.key}"

  parameters = {
    ConfigurationNameParam = each.key
    IamRoleArnArnParam     = aws_iam_role.chatbot.*.arn[0]
    SnsTopicArnsParam      = join(",", flatten([var.alarm_sns_topic_arns]))
    SlackChannelIdParam    = each.value.channel
    SlackWorkspaceIdParam  = each.value.workspace
    LoggingLevelParam      = var.logging_level
  }
  template_body = file("${path.module}/cf-chatbot.yml")
}

#--------------

resource "aws_iam_role" "chatbot" {
  count              = var.enabled ? 1 : 0
  name               = "${var.org_name}-${var.workspace_name}-chatbot-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_chatbot.*.json[0]
  tags               = var.tags
}

#--------------

resource "aws_iam_role_policy_attachment" "chatbot_policy" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.chatbot.*.name[0]
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy_document" "assume_role_chatbot" {
  count = var.enabled ? 1 : 0
  statement {

    principals {
      type = "Service"
      identifiers = [
        "chatbot.amazonaws.com"
      ]
    }
    actions = [
      "sts:AssumeRole",
    ]
  }
}
