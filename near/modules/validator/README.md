# validator

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ami"></a> [ami](#module\_ami) | ../ami | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ec2_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ec2_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_user.ssm_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.ssm_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_instance.near_validator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_iam_policy_document.ec2_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_initial_startup"></a> [initial\_startup](#input\_initial\_startup) | Will allow the initial startup and sync of nearcore | `bool` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | AWS instance type for this node | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | Near network | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | VPC Security group for this instance | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID to place this proxy. This should be a public subnet from your near VPC. | `string` | n/a | yes |
| <a name="input_twilio"></a> [twilio](#input\_twilio) | Configuration for twilio msg service | <pre>object({<br>    twilio_messaging_service_sid = string<br>    twilio_account_sid           = string<br>    twilio_auth_token            = string<br>    twilio_number_to_send        = string<br>    twilio_number                = string<br>  })</pre> | n/a | yes |
| <a name="input_validator"></a> [validator](#input\_validator) | Configuration for zero or more proxies in each availability zone. | <pre>object({<br>    validator_name = string<br>    gmail_address  = string<br>    gmail_password = string<br>    validator_key  = string<br>    # node_key       = string<br>    account_id     = string<br>    stakingpool_id = string<br>  })</pre> | n/a | yes |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | GB size for the EBS volume | `number` | `256` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instances"></a> [instances](#output\_instances) | n/a |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
