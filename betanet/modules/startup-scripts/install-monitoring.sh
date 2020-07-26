#!/bin/bash

EMAIL_ADDRESS=${email_address}
EMAIL_PASSWORD=${email_password}
POOL_ID=${stakingpool_id}


cd
#Run Node Exporter on the Node
docker run -dit \
    --restart always \
    --volume /proc:/host/proc:ro \
    --volume /sys:/host/sys:ro \
    --volume /:/rootfs:ro \
    --name node-exporter \
    -p 9100:9100 prom/node-exporter:latest \
    --path.procfs=/host/proc \
    --path.sysfs=/host/sys

#Run Near Exporter on the Node
pwd
git clone https://github.com/masknetgoal634/near-prometheus-exporter
cd near-prometheus-exporter
docker build -t near-prometheus-exporter .
docker run -dit \
    --restart always \
    --name near-exporter \
    --network=host \
    -p 9333:9333 \
    near-prometheus-exporter:latest /dist/main -accountId "$POOL_ID"

#Configure the Near Node as Target on Prometheus Server
pwd 

#Edit file to add this servers IP
IP=$(curl ifconfig.me)
sed -i  "s/<NODE_IP_ADDRESS>/"$IP"/g" etc/prometheus/prometheus.yml
pwd
#Run Prometheus on your server monitoring machine
docker run -dti \
    --restart always \
    --volume $(pwd)/etc/prometheus:/etc/prometheus/ \
    --name prometheus \
    --network=host \
    -p 9090:9090 prom/prometheus:latest \
    --config.file=/etc/prometheus/prometheus.yml

#Run Grafana
USR=$(id -u)

chown -R "$USR:$USR" etc/grafana/*

docker run -dit \
    --restart always \
    --volume $(pwd)/etc/grafana:/var/lib/grafana \
    --volume $(pwd)/etc/grafana/provisioning:/etc/grafana/provisioning \
    --volume $(pwd)/etc/grafana/custom.ini:/etc/grafana/grafana.ini \
    --user "$USR" \
    --network=host \
    --name grafana \
    -p 3000:3000 grafana/grafana

#Grafana Email Notification Alert
pwd
sed -i  "s/<your_gmail_address>/"$EMAIL_ADDRESS"/g" etc/grafana/custom.ini
sed -i  "s/<your_gmail_password>/"$EMAIL_PASSWORD"/g" etc/grafana/custom.ini