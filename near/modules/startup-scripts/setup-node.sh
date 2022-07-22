#! /bin/bash
#! /bin/bash/expect

#Set login
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN

#change $HOME to install packages as ubuntu
export HOME=/home/ubuntu
NEAR_DIRECTORY=.near/${network}
network=${network}
initialstartup=${initialstartup}
cd $HOME


sudo apt update && sudo apt upgrade -y
sudo apt-get install -y nodejs
#Install node v 12 and npm
su - ubuntu -c yes | curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
su - ubuntu -c yes | sudo apt install build-essential nodejs
su - ubuntu -c yes | sudo apt install npm 
PATH="$PATH"


#Install near-cli
echo "export NODE_ENV=$network" >> ~/.bashrc 
su - ubuntu -c echo "export NODE_ENV=$network" >> $HOME/.profile 
su - ubuntu -c sudo yes | npm install -g near-cli

export NEAR_ENV=shardnet
echo 'export NEAR_ENV=shardnet' >> ~/.bashrc

pwd
#Install nearup and make globally executable
apt-get update
sudo apt-get install containerd=1.3.3-0ubuntu2
apt install  --assume-yes python3 python3-pip python3-dev
pip3 install --upgrade pip

USER_BASE_BIN=$(python3 -m site --user-base)/bin
export PATH="$USER_BASE_BIN:$PATH"

sudo apt install clang build-essential make
sudo apt install libcurl4-openssl-dev libssl-dev
sudo chown -R $(whoami) /home
sudo curl https://sh.rustup.rs -sSf | \
    sh -s -- -y --no-modify-path --default-toolchain none
source "$HOME/.cargo/env"
# sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# source $HOME/.cargo/env

git clone https://github.com/near/nearcore
cd nearcore
git config --global --add safe.directory /home/ubuntu/nearcore
git fetch
git checkout 8448ad1eb

sudo apt install cargo
sudo chown -R $(whoami) /home
sudo apt install clang
cargo build -p neard --release --features shardnet
sudo ./target/release/neard --home ~/.near init --chain-id shardnet --download-genesis

apt-get install wget
sudo rm ~/.near/config.json
sudo wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json

sudo apt-get install awscli -y
# pip3 install awscli --upgrade
cd ~/.near
aws s3 --no-sign-request cp s3://build.openshards.io/stakewars/shardnet_noarchive/data.tar.gz .  
tar -xzvf data.tar.gz

cd ~/nearcore
# sudo ./target/release/neard run




sudo printf "[Unit]
Description=NEARd Daemon Service

[Service]
Type=simple
User=ubuntu
#Group=near
WorkingDirectory=/home/ubuntu/.near
ExecStart=/home/ubuntu/nearcore/target/release/neard run
Restart=on-failure
RestartSec=30
KillSignal=SIGINT
TimeoutStopSec=45
KillMode=mixed

[Install]
WantedBy=multi-user.target" > "/etc/systemd/system/neard.service"

sudo systemctl enable neard
sudo systemctl start neard

sudo apt install ccze
journalctl -n 100 -f -u neard | ccze -A

# su - ubuntu -c 'pip3 install --user nearup'

# #Load on interactive bash 
# # echo 'source $HOME/.nearup/env' >> ~/.bashrc 
# #Ensure nearup is available
# # source ~/.profile

# #Start nearup, stop, replace keys and start again
# cd $HOME
# nearup run ${network} --account-id ${stakingpool_id} 
if [ !$intialstartup ]; then
    pwd
    cd $NEAR_DIRECTORY
    rm -rf data
    mkdir ~/.near
    echo -n '${validator_key}' > ~/.near/validator_key.json
    echo -n '${node_key}' > ~/.near/node_key.json
    sudo systemctl start neard
    journalctl -n 100 -f -u neard | ccze -A
fi




# #Give ubuntu access to .near
# apt-get install -y acl
# setfacl -R -m u:ubuntu:rwx /home/ubuntu/.near
# setfacl -R -m u:ubuntu:rwx /home/ubuntu/.nearup





