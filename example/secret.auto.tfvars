region = "us-east-2" #The region the validator is set up

key_pair_name = "East2" //Your AWS key pair for the region


proxy = {
    validator_name = "The Passive Trust"
    gmail_address = "johndoe@gamil.com"
    gmail_password = "abc123"
    validator_key = "{\"account_id\":\"thepassivetrust.stakehouse.betanet\",\"public_key\":\"ed25519:3Q1hfkL18bbXqPrwo5aATFQqdroNajHp7jTu1YbBCH8U\",\"secret_key\":\"ed25519:3MYwVigQWgPVnph4mCgs8VgPFEd7anLdz3yG4ogRrCNEsR8BuEJdaKmTWz5FUPckshj7VuuVcD4tHy5pXL3PyFF6\"}"
    node_key = "{\"account_id\":\"\",\"public_key\":\"ed25519:6vbbidaCaGMPFjPmQg96g73B1BgomgLa19edkbnUjLTs\",\"secret_key\":\"ed25519:RCgPKEcAPms7ve9FQY1yMVZgdz7RphmBidv6rYsdyZ6V8D5wFoawQzMBNYSm8em37ZYUVZKkT5mgRDMz9aznedF\"}"
    account_id = "thepassivetrust-near@betanet"
    stakingpool_id = "thepassivetrust.stakehouse.betanet"
    seat_price_percentage = 1.3
    lower_bid_threshold = 1.1
    upper_bid_threshold = 1.8

}

network = "betanet"