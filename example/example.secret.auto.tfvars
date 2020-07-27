
//Example file for secrets

region = "us-east-2" #The region the validator is set up

key_pair_name = "East2" //Your AWS key pair for the region

proxy = {
    validator_name = "validator"
    gmail_address = "johndoe@gamil.com"
    gmail_password = "abc123"
    validator_key = "{\"account_id\": \"contract.stakehouse.betanet\",\"public_key\": \"ed25519:3Q7hjlso8bbXqPrwo5aATFQqdrkjijHp7jTu1YbBCH8U\",\"secret_key\": \"ed25519:3MYwVigQWgPVnph4mCgshhhhhhd7anLdz3ykligRrCNEsR8BuEJdaKmTWz5FUPckshj7VuuVcD4tHy5pXL3PyFF6\"}"
    node_key = "{\"account_id\": \"\",\"public_key\": \"ed25519:6vbbidaCaGMPFjPmQg96g73B64hfbgLa19edkbnUjLTs\",\"secret_key\": \"ed25519:RCgPKEcAPms7ve9FQY1yMVZgdz7RphmBjisbhYsdyZ6V8D5wFoawQzMBNYSm8em37ZYUVZKkT5mgRDMz9aznedF\"}"
    account_id = "account@betanet"
    stakingpool_id = "stakepool.stakehouse.betanet"
}