#bash script file to automate EKS CLUSTER SETUP with Terraform

#!/bin/bash

set -e

# Variable Declaration
folder_name="$HOME/.kube"
terraform_version="0.13.4"
kubectl_version="v1.23.6"

echo "##############################################################################################"
echo "Authenticating User Access" #Download awscli and Configured your Access credentials
echo "##############################################################################################"

echo "##############################################################################################"
echo "Applying Patches to Bootstrapper Server"
echo "##############################################################################################"

sudo apt-get update -y 

echo "##############################################################################################"
echo "Downloading Unzip and git"
echo "##############################################################################################"

sudo apt-get install -y wget unzip git

echo "##############################################################################################"
echo "Installing Terraform"
echo "##############################################################################################"

cd /tmp
wget https://releases.hashicorp.com/terraform/"$terraform_version"/terraform_"$terraform_version"_linux_amd64.zip
sudo unzip -o terraform_"$terraform_version"_linux_amd64.zip -d /usr/local/bin
terraform version

echo "##############################################################################################"
echo "Clone the Terraform-EKS repo"
echo "##############################################################################################"

git clone https://github.com/auskatodd/Terraform-EKS.git
cd Terraform-EKS 

echo "##############################################################################################"
echo "Installing kubectl"
echo "##############################################################################################"

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$kubectl_version/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin

echo "##############################################################################################"
echo "Downloading aws-iam-authenticator"
echo "##############################################################################################"

curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/"$kubectl_version"/2022-01-28/bin/linux/amd64/aws-iam-authenticator
sudo chmod +x aws-iam-authenticator
sudo mv aws-iam-authenticator /usr/local/bin/

echo "##############################################################################################"
echo "Starting Terraform Provisioning"
echo "##############################################################################################"

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

echo "##############################################################################################"
echo "Waiting for EKS cluster to become available"
echo "##############################################################################################"

sleep 300

echo "##############################################################################################



