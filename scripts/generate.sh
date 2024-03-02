#!/bin/sh
##
# Script to deploy a Kubernetes project with a StatefulSet running a MongoDB Replica Set, to a local Minikube environment.
##

# Create keyfile for the MongoD cluster as a Kubernetes shared secret
TMPFILE=$(mktemp)
/usr/bin/openssl rand -base64 741 > $TMPFILE
microk8s kubectl create secret generic shared-bootstrap-data --from-file=internal-auth-mongodb-keyfile=$TMPFILE -n dev
rm $TMPFILE

# Create mongodb service with mongod stateful-set
# TODO: Temporarily added no-valudate due to k8s 1.8 bug: https://github.com/kubernetes/kubernetes/issues/53309
microk8s kubectl apply -f ../resources/mongodb-service.yaml --validate=false -n dev
sleep 5

# Print current deployment state (unlikely to be finished ye
microk8s kubectl get all 
microk8s kubectl get persistentvolumes
echo
echo "Keep running the following command until all 'mongod-n' pods are shown as running:  kubectl get all"
echo

