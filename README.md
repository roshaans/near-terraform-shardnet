# near-terraform

## Overview

[NEAR Protocol](https://near.org/) is a decentralized application platform that is secure enough to manage high value assets like money or identity and performant enough to make them useful for everyday people, putting the power of the Open Web in their hands.

[Terraform](https://www.terraform.io) is a tool by Hashicorp that allows developers to treat _"infrastructure as code"_, easying the management and repeatibility of the
infrastructure.
Infrastructure and all kind of cloud resources are defined in modules, and Terraform creates/changes/destroys when changes are applied.

Inside the [near](./near) folder you will find a module (and submodules) to create the setup for running a NEAR Validator on AWS. The next logic resources can be created:

- `vpc` module for setting up a VPC with a public and private subnet. bastion and validator nodes go in the public subnet(a private subnet is available to eventually allow for the validator and for sentry nodes in the public subnet).
- `validator` module for creating a Proxy connected to a validator.


## Operating System

All nodes run on the Ubuntu LTS 18.04 AMI. Running `terraform apply` will select the latest available AMI.



## Requirements

Inside the [example](./example) folder you can find an example tf to use the module. Use that tf as base file for your deployment, modifying the account variables used for your convenience.
Alternatively you can take that tf files as base for customizing your deployment. Please take care specially about the VPC network configuration. 


## Installation

**This guide assumes you already have a validator setup with an account and a staking pool contract deployed. If not, please visit [NEAR DOCS](https://docs.near.org/docs/validator/staking-overview) for more information before continuing**

```git clone https://github.com/abellinii/near-terraform.git ```

```cd near-terraform/example; cp example.secret.auto.tfvars secret.auto.tfvars```

Populate the ``` secret.auto.tfvars ``` file with your near configuration details.

If it the the first time on the network and you do not have keys or a pool set ```initial_startup = true```  and ssh in to create your stake pool. Testnet documentation can be found [here](https://github.com/nearprotocol/stakewars/blob/master/GUIDELINES.md#additional-guidelines-for-validators-joining-testnet)


### AWS

This infracstructure setup is using [AWS](https://aws.amazon.com/). You will need an AWS account and to have the AWS CLI installed and logged in to use this package. Information can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)


``` Terraform init```

```Terraform Apply```

### SSH

To access the node you will first need to access the bastion as it is the only IP you shh into the validator. To do that:

```ssh-add -K /path/to/your/key.pem```

```ssh -A ubuntu@<BastionIP>```

```ssh ubuntu@<validatorIP>```


## Installed Packages
 

### Nearup

[Nearup](https://github.com/near/nearup) is NEAR's public scripts to launch near betanet and testnet node. This is installed on provisioning.

### Near-shell

[NEAR Shell](https://docs.near.org/docs/development/near-shell) is a fully featured NodeJS command line application that wraps near-api-js

### Prometheus and Grafana

[Prometheus](https://prometheus.io/) is installed on startup to expose metrics for the NEAR validating node and the system. [Grafana](https://grafana.com/) is installed to help vsualize these metrics with a dashboard that is customized to show relevant metrics for NEAR validating nodes. The majority is configured and can be accessed by <NODE IP>:3000 and default username and password is admin admin.

This was Near's Stake Wars Challenge 3 and a few great tutorials in various languages can be found [here](https://github.com/nearprotocol/stakewars/blob/master/challenges/challenge003.md)  

### CI Integration

A CI Workflow that will check the latest release of nearcore and will build from source, test and create a docker image in a docker repository you create. Props go to [masknetgoal634](https://github.com/masknetgoal634) for his implementation [here](https://github.com/masknetgoal634/nearcore-deploy). 

Add these 3 secrets to your Gthub secrets(for a detailed look at whats happening please view the github link to the package):

```
DOCKER_IMAGE_NAME
DOCKER_USERNAME
DOCKER_PASSWORD
```

Create a `validator_key.json` 

*   Generate the Key file:

```
near generate-key <pool_id>
```
<pool_id> ---> xx.factory.shardnet.near WHERE xx is you pool name

* Copy the file generated to shardnet folder:
Make sure to replace <pool_id> by your accountId

* Edit “account_id” => xx.factory.shardnet.near, where xx is your PoolName
* Change `private_key` to `secret_key`

> Note: The account_id must match the staking pool contract name or you will not be able to sign blocks.\

File content must be in the following pattern:
```
{
  "account_id": "xx.factory.shardnet.near",
  "public_key": "ed25519:HeaBJ3xLgvZacQWmEctTeUqyfSU4SDEnEwckWxd92W2G",
  "secret_key": "ed25519:****"
}<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
