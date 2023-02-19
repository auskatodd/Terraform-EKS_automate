#bash script file to automate EKS CLUSTER SETUP with Terraform

#!/bin/bash

# Variable Declaration
return=$?
folder_name="~/.kube"

echo "##############################################################################################"
echo "Authenticating you User Access" #Download awscli and Configured your Access credentials
echo "##############################################################################################"

echo "##############################################################################################"
echo "Applying Patches to Bootstrapper Server"
echo "##############################################################################################"

sudo apt update -y 

echo "##############################################################################################"
echo "Downloading Unzip and git"
echo "##############################################################################################"

sudo apt install wget -y && sudo apt install unzip -y && sudo apt install git -y

echo "Move to temporal directory to install Terraform, unarchive and move it to bin directory"
cd /tmp
wget https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_linux_amd64.zip
sudo unzip -o terraform_0.13.4_linux_amd64.zip -d /usr/local/bin
unzip -o terraform_0.13.4_linux_amd64.zip
sudo mv terraform /usr/local/bin
cd
terraform version

echo "##############################################################################################"
echo "Clone the EtechDevops-EKS repo"
echo "##############################################################################################"

git clone https://github.com/auskatodd/Terraform-EKS.git
cd ~/Terraform-EKS 

##############################################################################################
echo "Installing the kubectl client on the Bootstrapper"
echo "##############################################################################################"

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin

echo "##############################################################################################"
echo "Downloading the aws-iam-authenticator"
echo "##############################################################################################"

wget https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64
sudo chmod +x heptio-authenticator-aws_0.3.0_linux_amd64
sudo mv heptio-authenticator-aws_0.3.0_linux_amd64 /usr/local/bin/heptio-authenticator-aws


echo "##############################################################################################"
echo "Starting Terraform Provisioning"
echo "##############################################################################################"

cd ~/Terraform-EKS
terraform init 

echo "##############################################################################################"
echo "Checking for Syntax Errors"
echo "##############################################################################################"

terraform validate

echo "##############################################################################################"
echo "All Resources to be Provisioned"
echo "##############################################################################################"

terraform plan

echo "##############################################################################################"
echo "Provisioning the Resources"
echo "##############################################################################################"

terraform apply  -auto-approve 


