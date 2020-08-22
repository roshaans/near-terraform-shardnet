
//Example file for secrets

region = "us-east-2" #The region the validator is set up

key_pair_name = "East2" #Your AWS key pair for the region


validator = {
    validator_name      = "validator"  #The name you would like to call your validator
    gmail_address       = "johndoe@gamil.com" #Email address you would like associated with your validator to recieve alerts from grafana
    gmail_password      = "abc123" #Email addresses password
    validator_key       = "{\"account_id\": \"contract.stakehouse.betanet\",\"public_key\": \"ed25519:3Q7hjlso8bbXqPrwo5aATFQqdrkjijHp7jTu1YbBCH8U\",\"secret_key\": \"ed25519:3MYwVigQWgPVnph4mCgshhhhhhd7anLdz3ykligRrCNEsR8BuEJdaKmTWz5FUPckshj7VuuVcD4tHy5pXL3PyFF6\"}" #Your validator key
    node_key            = "{\"account_id\": \"\",\"public_key\": \"ed25519:6vbbidaCaGMPFjPmQg96g73B64hfbgLa19edkbnUjLTs\",\"secret_key\": \"ed25519:RCgPKEcAPms7ve9FQY1yMVZgdz7RphmBjisbhYsdyZ6V8D5wFoawQzMBNYSm8em37ZYUVZKkT5mgRDMz9aznedF\"}" #Your node key
    account_id          = "account@betanet" #the account you hold your warchest tokens in
    stakingpool_id      = "stakepool.stakehouse.betanet" #Your staking pool contract address

}

network = "betanet"

twilio = {
    twilio_messaging_service_sid  = "MG775f284286a9e20aassddwff81bab118"
    twilio_account_sid            = "AC925c6aa32894a39d1d7sjnevgiib9594"
    twilio_auth_token             = "579d06428a08a2ac3f0ee856dnfhuidd"
    twilio_number_to_send         = "+17787878788"
    twilio_number                 = "+16047889799"
}

docker_image = "yourRepository/nearcore:beta"

iniitial_startup = true