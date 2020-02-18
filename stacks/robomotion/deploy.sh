#!/bin/sh

set -e

# create namespace
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: robomotion-system
EOF

# set kubectl namespace
kubectl config set-context --current --namespace=robomotion-system

# deploy redskyops
kubectl apply -f https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/robomotion/yaml/robomotion.yaml

# ensure services are running
kubectl rollout status -w deployment/robomotion-api
kubectl rollout status -w deployment/robomotion-proxy
kubectl rollout status -w deployment/robomotion-scheduler
kubectl rollout status -w deployment/robomotion-authorization
kubectl rollout status -w deployment/robomotion-admin
kubectl rollout status -w deployment/robomotion-designer
