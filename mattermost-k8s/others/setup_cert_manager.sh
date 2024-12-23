#!/bin/bash
set -e

echo "Deploying Cert-Manager..."
kubectl apply -f https://github.com/jetstack/cert-manager/releases/latest/download/cert-manager.yaml

echo "Waiting for Cert-Manager pods to be ready..."
kubectl wait --namespace cert-manager \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=webhook \
  --timeout=600s
echo "Cert-Manager deployed successfully."
