#!/usr/bin/env bash

#Change dir to /workspace
cd /workspace

#Remove old awscli.zip file and aws directory before downloading and installing awscli
rm -f '/workspace/awscliv2.zip'
rm -rf '/workspace/aws'

#download and install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#Change dir back to PROJECT_ROOT
cd $PROJECT_ROOT

#Print aws cli credentials under which we are connected to AWS Cloud
aws sts get-caller-identity