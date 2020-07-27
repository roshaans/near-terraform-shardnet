#! /bin/bash

#Set login
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN


#Install node v 12 and npm
su - ubuntu -c yes | curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
su - ubuntu -c yes | sudo apt-get install nodejs
su - ubuntu -c yes | sudo apt install npm 
sudo chown -R ubuntu ~/.npm
sudo chown -R ubuntu /usr/local/lib/node_modules


#Install near-shell
echo 'export NODE_ENV=betanet=' >> ~/.bashrc 
su - ubuntu -c yes | npm install -g near-shell




HOME_DIRECTORY=/home/ubuntu
NEAR_DIRECTORY=.near/betanet
export HOME=/root
cd $HOME_DIRECTORY

#Install nearup and make globally executable
apt-get update
apt-get --assume-yes install python3 git curl
curl --proto '=https' --tlsv1.2 -sSfL https://up.near.dev | python3

sed -e 's|/root/.nearup/env:||g' -i /etc/environment 
sed -e 's|PATH="\(.*\)"|PATH="/root/.nearup/env:\1"|g' -i /etc/environment

sed -e 's|/root/.nearup/env:||g' -i ~/.profile 
sed -e 's|PATH="\(.*\)"|PATH="/root/.nearup/env:\1"|g' -i ~/.profile

source ~/.profile


#Start nearup, stop, replace keys and start again
cd
echo -ne ${stakingpool_id} | nearup ${network} 
nearup stop
cd $NEAR_DIRECTORY
echo -n '${validator_key}' > validator_key.json
echo -n '${node_key}' > node_key.json
nearup ${network} 







