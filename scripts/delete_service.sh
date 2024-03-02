#!/bin/sh
##
# Script to just undeploy the MongoDB Service & StatefulSet but nothing else.
##

# Just delete mongod stateful set + mongodb service onlys (keep rest of k8s environment in place)
microk8s kubectl delete statefulsets mongod -n dev
microk8s kubectl delete services mongodb-service -n dev

# Show persistent volume claims are still reserved even though mongod stateful-set has been undeployed
microk8s kubectl get persistentvolumes -n dev

