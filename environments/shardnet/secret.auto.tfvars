
//Example file for secrets
iniitial_startup = true
region           = "us-east-1" #The region the validator is set up

validator = {
  validator_name = "degods validator"                                                                                                                                                                                                                                 #The name you would like to call your validator
  gmail_address  = "degodsvalidator@gamil.com"                                                                                                                                                                                                                        #Email address you would like associated with your validator to recieve alerts from grafana
  gmail_password = "kitchen581!"                                                                                                                                                                                                                                      #Email addresses password
  validator_key  = "{\"account_id\": \"degods.factory.shardnet.near\",\"public_key\": \"ed25519:F9ENqhnG1HhpG5hStfUbYVb2NPsFTfUUwAATai11xMNc\",\"secret_key\": \"ed25519:4QSVNMoRUcFEtrn2vuFzpVNNQwrh3waRbidCGVwcSHmoxZiFDcKKzepwdFvktwRLSDuTDn67p1dgVvnG7DUutF5N\"}" #Your validator key
  account_id     = "degods.shardnet.near"                                                                                                                                                                                                                             #the account you hold your warchest tokens in
  stakingpool_id = "degods.factory.shardnet.near"                                                                                                                                                                                                                     #Your staking pool contract address
}

network = "shardnet"

twilio = {
  twilio_messaging_service_sid = "MG775f284286a9e20aassddwff81bab118"
  twilio_account_sid           = "AC925c6aa32894a39d1d7sjnevgiib9594"
  twilio_auth_token            = "579d06428a08a2ac3f0ee856dnfhuidd"
  twilio_number_to_send        = "+7739715928"
  twilio_number                = "+7739715928"
}

docker_image = "nearprotocol/nearcore"


