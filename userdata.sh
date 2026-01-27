#!/bin/bash
dnf install -y java git
wget https://dlcdn.apache.org/nifi/2.7.2/nifi-2.7.2-bin.zip
unzip nifi-2.7.2-bin.zip -d /home/ec2-user
git clone https://github.com/memaldi/muba_practica_nifi /home/ec2-user/muba_practica_nifi
cp /home/ec2-user/muba_practica_nifi/nifi.properties /home/ec2-user/nifi-2.7.2/conf/
./home/ec2-user/nifi-2.7.2/bin/nifi.sh start