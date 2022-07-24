# near

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_near_validator"></a> [near\_validator](#module\_near\_validator) | ./modules/validator | n/a |
| <a name="module_near_vpc"></a> [near\_vpc](#module\_near\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | The cidr\_blocks for the different subnets in a redundant near network | <pre>object({<br>    vpc                 = string<br>    subnet_1_public     = string<br>    subnet_1_private    = string<br>    allowed_ssh_clients = string<br>  })</pre> | <pre>{<br>  "allowed_ssh_clients": "0.0.0.0/0",<br>  "subnet_1_private": "10.10.1.0/24",<br>  "subnet_1_public": "10.10.0.0/24",<br>  "vpc": "10.10.0.0/16"<br>}</pre> | no |
| <a name="input_initial_startup"></a> [initial\_startup](#input\_initial\_startup) | Will allow the initial startup and sync of nearcore | `bool` | `true` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | The instance type for each component | `map(string)` | <pre>{<br>  "bastion": "t3.micro",<br>  "validator": "t3.xlarge"<br>}</pre> | no |
| <a name="input_network"></a> [network](#input\_network) | Near network | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region to provision this cluster | `string` | n/a | yes |
| <a name="input_twilio"></a> [twilio](#input\_twilio) | Configuration for twilio message service. | <pre>object({<br>    twilio_messaging_service_sid = string<br>    twilio_account_sid           = string<br>    twilio_auth_token            = string<br>    twilio_number_to_send        = string<br>    twilio_number                = string<br>  })</pre> | n/a | yes |
| <a name="input_validator"></a> [validator](#input\_validator) | Configuration for zero or more proxies in each availability zone. | <pre>object({<br>    validator_name = string<br>    gmail_address  = string<br>    gmail_password = string<br>    validator_key  = string<br>    # node_key       = string<br>    account_id     = string<br>    stakingpool_id = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
