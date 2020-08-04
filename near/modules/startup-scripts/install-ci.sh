#!/bin/bash

export HOME=/home/ubuntu

apt-get install jq

cd && mkdir near-ci && cd near-ci


#Add env to profile
su - ubuntu -c cat >> ~/home/ubuntu/.profile << x

#Add near-ci as a path
export PATH="$HOME/near-ci:$PATH"

#Twilio vars
export TWILIO_MESSAGING_SERVICE_SID=\${twilio_msg_sid}
export TWILIO_ACCOUNT_SID=\${twilio_account_sid}
export TWILIO_AUTH_TOKEN=\${twilio_auth_token}
export TWILIO_NUMBER_TO_SEND=${number_to_send}
export TWILIO_NUMBER=\${twilio_number}
export NEARCORE_DOCKER_IMAGE=${image}
x



#Make ci-script
su - ubuntu -c cat > near-ci.sh << EOF
#!/bin/bash


#Bash script to place in a cron job on local server to check for updates of the lastest near version
#script should be run by a cron job hourly to detect the newest release in a timely fashion


source ~/.profile
ip=$(curl ifconfig.me)
network=$NEAR_NETWORK
image=$NEARCORE_DOCKER_IMAGE
msg="msg"
USER=$(whoami)
echo "Checking for updates"

diff <(curl -s https://rpc."$network".near.org/status | jq .version) <(curl -s http://127.0.0.1:3030/status | jq .version)
if [ $? -ne 0 ]; then
    echo "start update";
    version=$(curl -s https://rpc."$network".near.org/status | jq .version.version)
    strippedversion=$(echo "$version" | awk -F "\"" '{print $2}' | awk -F "-" '{print $1}')
    
    nearup stop
    nearup "$network" --image "$image"

    #Test new release

    echo "Testing image is updated"
    diff <(curl -s https://rpc."$network".near.org/status | jq .version) <(curl -s http://127.0.0.1:303"$count"/status | jq .version)
    if [ $? -eq 0 ]
    then
        msg="Validator update with new $network $versionStripped"
        ./twilio.sh "$msg"
        echo "Validator update with new $network $versionStripped"
    else
        cd && mv /home/$USER/nearcore.bak /home/$USER/nearcore
        msg="Node Upgade failed - Still running old version - Check setup immediately"
        echo $msg
        ./twilio.sh "$msg"
        exit 1
    fi
    

    echo "Upgrade complete"


fi

EOF


#Install Twilio script

su - ubuntu -c cat > twilio.sh << EOF

#!/bin/bash

#Generic script to send messages to a mobile phone
#   - loads ENV variables for security purposes
#       - TWILIO_ACCOUNT_SID
#       - TWILIO_AUTH_TOKEN
#       - TWILIO_NUMBER_TO_SEND #number you want the message sent to 
#       - TWILIO_NUMBER #Number in your tewilio account
#   - Accepts 1 paramter that is the message you would like to send
#   - Send the message using twilio




#message given to send
msg=$1
account_sid=$TWILIO_ACCOUNT_SID
auth_token=$TWILIO_AUTH_TOKEN
number=$TWILIO_NUMBER_TO_SEND
twilio_number=$TWILIO_NUMBER


    
    
   

#send text message
curl --silent --output /dev/null -X POST -d "Body=${msg}" \
    -d "From=${twilio_number}" -d "To=${number}" \
    "https://api.twilio.com/2010-04-01/Accounts/${account_sid}/Messages" \
    -u "${account_sid}:${auth_token}"

EOF

#Make scripts executable
chmod +x /home/ubuntu/near-ci/updateNear.sh
chmod +x /home/ubuntu/near-ci/twilio.sh

#set cronjob
echo "@hourly script --return --quiet --append --command \"cd /home/$USER/near-ci && ./updateNear.sh 2>&1\" /home/$USER/near-ci/update.log" | crontab -


