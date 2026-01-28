#!/bin/bash
chown ec2-user:ec2-user /home/ec2-user/.aws
dnf install -y java git
wget https://dlcdn.apache.org/nifi/2.7.2/nifi-2.7.2-bin.zip
unzip nifi-2.7.2-bin.zip -d /home/ec2-user
git clone https://github.com/memaldi/muba_practica_nifi /home/ec2-user/muba_practica_nifi
cp /home/ec2-user/muba_practica_nifi/nifi.properties /home/ec2-user/nifi-2.7.2/conf/
#chown -R ec2-user:ec2-user /home/ec2-user/nifi-2.7.2/
./home/ec2-user/nifi-2.7.2/bin/nifi.sh start

export HEART_DISEASE_BUCKET=heart-disease-muba-$(uuidgen)
export HIGH_CHOLESTEROL_BUCKET=high-cholesterol-muba-$(uuidgen)
export NORMAL_CHOLESTEROL_BUCKET=normal-cholesterol-muba-$(uuidgen)

aws s3api create-bucket --bucket $HEART_DISEASE_BUCKET
aws s3api create-bucket --bucket $HIGH_CHOLESTEROL_BUCKET
aws s3api create-bucket --bucket $NORMAL_CHOLESTEROL_BUCKET

cat <<EOF > /etc/profile.d/buckets.sh
export HEART_DISEASE_BUCKET=$HEART_DISEASE_BUCKET
export HIGH_CHOLESTEROL_BUCKET=$HIGH_CHOLESTEROL_BUCKET
export NORMAL_CHOLESTEROL_BUCKET=$NORMAL_CHOLESTEROL_BUCKET
EOF