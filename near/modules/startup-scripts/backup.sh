#!/bin/bash


#-------------------------------------------------Set up backup job---------------------------------------------------

#Get Vars
network=${network}
bucket=${bucket}

#install AWS CLI
sudo apt-get -y update
sudo apt-get -y install awscli

#Install parralell to execute jobs in parallel
sudo apt install parallel



# Alternative application to use for sending data to S3
#Use in conjuction with these config settings
# https://tecadmin.net/install-s3cmd-manage-amazon-s3-buckets/
    #sudo apt-get -y install s3cmd





#Create new file for credentials
mkdir .aws/credentials

#variables known and import to credentials
aws_access_key_id=`aws_access_key_id=${aws_access_key_id}`
aws_secret_access_key=`aws_secret_access_key=${aws_secret_access_key}`
cat "[default]" > /.aws/credentials
cat "$aws_secret_access_key" > /.aws/credentials
cat "$aws_secret_access_key" > /.aws/credentials 



#This link will give me the best knowledge to do incremental backups https://ops.tips/blog/incremental-backup-linux/

cat > /backup.sh << EOF
#!/bin/bash

#make backup so data is not changed during the upload
cp -R .near/$network/data .near/$network/data.bak


#Compress and send to S3
tar czf - .near/$network/data.bak | aws s3 cp - s3://$bucket/near/$network/backup.tar.gz

EOF

chmod +x /home/ubuntu/backup.sh

cron="echo '@hourly script --return --quiet --append --command \"cd /home/ubuntu && ./backup.sh 2>&1\" /home/ubuntu/backup.log' | crontab -"

su - ubuntu -c "$cron"




#---------------------------------------Pull existing backup if one is available--------------------------------------

#Use this to pull the lastest backup if there is one

aws s3 cp s3://"$bucket"/near/"$network/backup.tar.gz - | tar -xvz 

mv .near/"$network"/data.bak .near/"$network"/data

