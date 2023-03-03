#!/bin/bash

echo "################################################################"
echo "Post-provision Configuration: Checking .kube folder existence"
echo "################################################################"

if [ ! -d "$HOME/.kube" ]; then
	echo "Creating .kube Folder in home directory..."
	mkdir $HOME/.kube
else
	echo "Folder Created or Already Exist"
fi

echo "################################################################"
echo "Creating and Copying Configuration file to Destination"
echo "################################################################"
cd ~/Terraform-EKS
sudo chown -R ubuntu $HOME/.kube
terraform output kubeconfig > $HOME/.kube/config

echo "################################################################"
echo "Taking Ownership of Configuration File and Directory"
echo "################################################################"

sudo chown -R ubuntu $HOME/.kube/config

echo "################################################################"
echo "Configure config-map-auth-aws"
echo "################################################################"

terraform output config-map-aws-auth > configmap.yaml
kubectl apply -f configmap.yaml 
aws eks --region us-east-1 update-kubeconfig --name terraform-eks-demo

echo "################################################################"
echo "Steps to check your nodes"
echo "################################################################"

kubectl config get-contexts > test.log
cat test.log
sleep 60
kubectl get nodes | grep internal
