#!/bin/bash

sudo apt --assume-yes install jq

branch=$(( $network == "mainnet" ? "mainnet" : "V2/Docker" ))

#Add env to profile


cmd="
cat >> .profile << x

#Add near-ci as a path
export PATH=\"$HOME/near-ci:$PATH\"

#Twilio vars
export TWILIO_MESSAGING_SERVICE_SID=${twilio_msg_sid}
export TWILIO_ACCOUNT_SID=${twilio_account_sid}
export TWILIO_AUTH_TOKEN=${twilio_auth_token}
export TWILIO_NUMBER_TO_SEND=${number_to_send}
export TWILIO_NUMBER=${twilio_number}
export NEAR_NETWORK=${network}
x
"

su - ubuntu -c "$cmd"

su - ubuntu -c "git clone --single-branch --branch $branch https://github.com/abellinii/near-ci.git"

chmod +x /home/ubuntu/near-ci/updateNear.sh
chmod +x /home/ubuntu/near-ci/twilio.sh


cron="echo '@hourly script --return --quiet --append --command \"cd /home/ubuntu/near-ci && ./updateNear.sh 2>&1\" /home/ubuntu/near-ci/update.log' | crontab -"
su - ubuntu -c "$cron"



