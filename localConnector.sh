#!/bin/bash


#Bash script to place in a cron job on local server to check for updates of the lastest near version

diff <(curl -s https://rpc.betanet.near.org/status | jq .version) <(curl -s http://127.0.0.1:3030/status | jq .version)

if [ $? -ne 0 ]; then
    echo "start update";
    rm -rf /home/$USER/nearcore.bak
    mv /home/$USER/nearcore /home/$USER/nearcore.bak
    git clone --branch beta https://github.com/nearprotocol/nearcore.git
    cd /home/$USER/nearcore
    make release
    nearup stop
    nearup betanet --nodocker --binary-path /home/$USER/nearcore/target/release/
    echo "done"
fi