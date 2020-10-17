#!/bin/bash

#log
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN

#Install dependancies
source ~/.profile
sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes dist-upgrade
sudo apt install --assume-yes python3 git curl libclang-dev build-essential llvm runc gcc g++ unattended-upgrades make clang pkg-config libssl-dev libudev-dev g++ g++-multilib lib32stdc++6-7-dbg libx32stdc++6-7-dbg cmake jq

# sudo snap install rustup --classic
# rustup default nightly
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source /root/.cargo/env
source ~/.profile
rustup component add clippy-preview
rustup default nightly




#Get latest github release
regex="[0-9]+.[0-9]+.[0-9]+$"
latestrelease=`echo $(curl -s https://api.github.com/repos/nearprotocol/nearcore/releases | jq -c -r --arg regex "$regex" 'map(select(.tag_name | test($regex)))[0].tag_name')`

#Get nearcore and build
git clone https://github.com/nearprotocol/nearcore.git
cd nearcore/  && git checkout tags/$latestrelease
make release

target/release/neard init --chain-id="mainnet" --account-id=${stakepool_id}
target/release/neard run 2>&1|tee -a validator.log

