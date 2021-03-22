resource "aws_cloudformation_stack" "tf_chatbot" {
  count = var.enabled ? 1 : 0
  name  = "terraform-chatbot-${var.org_name}-${var.workspace_name}"
  parameters = {
    ConfigurationNameParam = "${var.org_name}-${var.workspace_name}"
    IamRoleArnArnParam     = aws_iam_role.chatbot-role.*.arn[0]
    SnsTopicArnsParam      = join(",",flatten([var.alarm_sns_topic_arns]))
    SlackChannelIdParam    = var.slack_channel_id
    SlackWorkspaceIdParam  = var.slack_workspace_id
    LoggingLevelParameter  = var.logging_level
  }
  template_body = file("${path.module}/cf-chatbot.yml")
}


resource "aws_iam_role" "chatbot-role" {
  count              = var.enabled ? 1 : 0
  name               = "${var.org_name}-${var.workspace_name}-chatbot-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_chatbot.*.json[0]
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "chatbot_policy" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.chatbot-role.*.name[0]
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
