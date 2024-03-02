#!/bin/sh
##
# Script to just deploy the MongoDB Service & StatefulSet back onto the exising Kubernetes cluster.
##

# Show persistent volume claims are still reserved even though mongod stateful-set not deploy
microk8s kubectl get persistentvolumes -n dev

# Deploy just the mongodb service with mongod stateful-set only
microk8s kubectl  apply -f ../resources/mongodb-service.yaml -n dev
sleep 5

# Print current deployment state (unlikely to be finished yet)
microk8s kubectl get all -n dev
microk8s kubectl get persistentvolumes -n dev
echo
echo "Keep running the following command until all 'mongod-n' pods are shown as running:  kubectl get all"
echo

