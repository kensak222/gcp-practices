#!/bin/bash
set -e

echo "Checking GKE Cluster state..."
gcloud container clusters list

echo "Checking Pod states in mattermost namespace..."
kubectl get pods -n mattermost

echo "Checking Ingress external IP..."
kubectl get ingress -n mattermost

echo "Please verify Mattermost by visiting: https://kenken.ddo.jp"
