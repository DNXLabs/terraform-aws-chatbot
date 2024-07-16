# terraform-aws-chatbot

[![Lint Status](https://github.com/DNXLabs/terraform-aws-chatbot/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-chatbot/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-chatbot)](https://github.com/DNXLabs/terraform-aws-chatbot/blob/master/LICENSE)

This terraform module creates AWS Chatbot and its dependencies.

The following resources will be created:

 - An Identity and Access Management (IAM)

In addition you have the option to:

 - Create aws chatboot workspace(s) and integrate to slack
 - Create AWS chatbot clients connecting to one or more slack channel(s) to send notification using AWS Chatbot

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| awscc | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_ids | list of accounts that can send notifications | `list` | `[]` | no |
| logging\_level | Specifies the logging level for this configuration. This property affects the log entries pushed to Amazon CloudWatch Logs. Logging levels include ERROR, INFO, or NONE. | `string` | `"ERROR"` | no |
| org\_name | Name for this organization | `any` | n/a | yes |
| slack\_targets | Use to define additional slack channels. Format: [ { slack\_channel\_name=xxxx , slack\_channel\_id=xxx, slack\_workspace\_id=xxx }] | `any` | `[]` | no |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map(string)` | <pre>{<br>  "Terraform": true<br>}</pre> | no |
| teams\_targets | Use to define additional slack channels. Format: [ { team\_id=xxxx , teams\_channel\_id=xxx, teams\_tenant\_id=xxx }] | `any` | `[]` | no |
| workspace\_name | Description for the chat integration | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| chatbot\_role\_arn | The ARN of the Chatbot role |
| chatbot\_role\_name | The name of the Chatbot role |

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-chatbot/blob/master/LICENSE) for full details.
