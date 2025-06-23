#!/bin/bash

CLUSTER_NAME=$1
if [[ -z $CLUSTER_NAME || ! -d clusters/${CLUSTER_NAME}/flux-system ]]; then
	echo "Usage: $0 {CLUSTER_NAME}"
	echo "Error: {CLUSTER_NAME} is required and a matching clusters/{CLUSTER_NAME}/flux-system directory should exist"
	exit 1
fi

kubectl kustomize clusters/${CLUSTER_NAME}/flux-system | kubectl apply -f -
sleep 10
kubectl kustomize clusters/${CLUSTER_NAME}/flux-system | kubectl apply -f -
sleep 10

flux create secret git flux-system \
	--url=ssh://git@github.com/maliksalman/learning-flux-cicd \
	--private-key-file=$HOME/.ssh/id_ed25519
