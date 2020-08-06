# terraform-aws-chatbot
[![Lint Status](https://github.com/DNXLabs/terraform-aws-chatbot/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-chatbot/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-chatbot)](https://github.com/DNXLabs/terraform-aws-chatbot/blob/master/LICENSE)


Utility Module to create AWS Chatbot and its dependencies - NEW README.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm\_sns\_topic\_arn | SNS Topic ARN to connect to AWS Chatbot | `any` | n/a | yes |
| enabled | If true, will create aws chatboot and integrate to slack | `string` | `"false"` | no |
| org\_name | Name for this organization | `any` | n/a | yes |
| slack\_channel\_id | Slack channel id to send budget notfication using AWS Chatbot | `string` | `""` | no |
| slack\_workspace\_id | Slack workspace id to send budget notfication using AWS Chatbot | `string` | `""` | no |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |
| workspace\_name | Description for the chat integration | `any` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->