#!/bin/bash

#WAR CHEST BOT INSTALLATION
#Creates a warchest of staked tokens, and dynamically maintain no more than one seat
#Using code from https://github.com/eorituz/near_warchest by https://github.com/eorituz


npm install -g near-shell
git clone https://github.com/eorituz/near_warchest.git


#Adapt const.py
cd near_warchest

sed -i  "s/stakeing.arno_nym.betanet/${stakepool_id}/g" const.py
sed -i  "s/arno_nym.betanet/${account_id}/g" const.py
sed -i  "s/betanet/${network}/g" const.py
sed -i  "s/1.3/${seat_price_percentage}/g" const.py
sed -i  "s/1.1/${lower_bid_threshold}/g" const.py
sed -i  "s/1.8/${upper_bid_threshold/g" const.py



PYTHON_PATH=$(whereis python)


cat > /etc/systemd/system/warchest_bot.service << EOF
[Unit]
Description=Warchest bot managing near stake
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=/"$PYTHON_PATH"/python3.6 /ubuntu/home/near_warchest/warchest.py

[Install]
WantedBy=multi-user.target
EOF


systemctl start warchest_bot


