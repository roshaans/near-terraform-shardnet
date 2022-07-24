# shardnet

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.74.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_near_cluster"></a> [near\_cluster](#module\_near\_cluster) | ../../near | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | The cidr\_blocks for the different subnets in a redundant Near network | <pre>object({<br>    vpc                 = string<br>    subnet_1_public     = string<br>    subnet_1_private    = string<br>    allowed_ssh_clients = string<br>  })</pre> | <pre>{<br>  "allowed_ssh_clients": "0.0.0.0/0",<br>  "subnet_1_private": "10.10.1.0/24",<br>  "subnet_1_public": "10.10.0.0/24",<br>  "vpc": "10.10.0.0/16"<br>}</pre> | no |
| <a name="input_initial_startup"></a> [initial\_startup](#input\_initial\_startup) | Will allow the initial startup and sync of nearcore | `bool` | `true` | no |
| <a name="input_network"></a> [network](#input\_network) | Near network | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region to provision this cluster | `string` | n/a | yes |
| <a name="input_twilio"></a> [twilio](#input\_twilio) | Configuration for twilio messaging service | <pre>object({<br>    twilio_messaging_service_sid = string<br>    twilio_account_sid           = string<br>    twilio_auth_token            = string<br>    twilio_number_to_send        = string<br>    twilio_number                = string<br>  })</pre> | n/a | yes |
| <a name="input_validator"></a> [validator](#input\_validator) | Configuration for zero or more proxies in each availability zone. | <pre>object({<br>    validator_name = string<br>    gmail_address  = string<br>    gmail_password = string<br>    validator_key  = string<br>    account_id     = string<br>    stakingpool_id = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
