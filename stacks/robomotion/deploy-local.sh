#!/bin/sh

set -e

ROOT_DIR=$(git rev-parse --show-toplevel)

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
kubectl apply -f "$ROOT_DIR"/stacks/robomotion/yaml/robomotion.yaml

# ensure services are running
kubectl rollout status -w robomotion-system/robomotion-api
kubectl rollout status -w robomotion-system/robomotion-proxy
kubectl rollout status -w robomotion-system/robomotion-scheduler
kubectl rollout status -w robomotion-system/robomotion-authorization
kubectl rollout status -w robomotion-system/robomotion-admin
kubectl rollout status -w robomotion-system/robomotion-designer