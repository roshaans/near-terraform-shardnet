
//Example file for secrets

region = "us-east-2" #The region the validator is set up

key_pair_name = "East2" #Your AWS key pair for the region


validator = {
    validator_name = "validator"  #The name you would like to call your validator
    gmail_address = "johndoe@gamil.com" #Email address you would like associated with your validator to recieve alerts from grafana
    gmail_password = "abc123" #Email addresses password
    validator_key = "{\"account_id\": \"contract.stakehouse.betanet\",\"public_key\": \"ed25519:3Q7hjlso8bbXqPrwo5aATFQqdrkjijHp7jTu1YbBCH8U\",\"secret_key\": \"ed25519:3MYwVigQWgPVnph4mCgshhhhhhd7anLdz3ykligRrCNEsR8BuEJdaKmTWz5FUPckshj7VuuVcD4tHy5pXL3PyFF6\"}" #Your validator key
    node_key = "{\"account_id\": \"\",\"public_key\": \"ed25519:6vbbidaCaGMPFjPmQg96g73B64hfbgLa19edkbnUjLTs\",\"secret_key\": \"ed25519:RCgPKEcAPms7ve9FQY1yMVZgdz7RphmBjisbhYsdyZ6V8D5wFoawQzMBNYSm8em37ZYUVZKkT5mgRDMz9aznedF\"}" #Your node key
    account_id = "account@betanet" #the account you hold your warchest tokens in
    stakingpool_id = "stakepool.stakehouse.betanet" #Your staking pool contract address
    docker _image = yourdockername/image #image of the docker build from the github action for CI

}