#! /bin/bash


#Set up logging for error checking
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN


HOME_DIRECTORY=/home/ubuntu
NEAR_DIRECTORY=.near/betanet
export HOME=/root
mkdir $HOME_DIRECTORY
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







