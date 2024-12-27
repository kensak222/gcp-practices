### others/deploy_resources.sh
#!/bin/bash
set -e

echo "Deploying Mattermost Namespace and resources..."
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/db/deployment.yaml
kubectl apply -f k8s/db/service.yaml
kubectl apply -f k8s/app/deployment.yaml
kubectl apply -f k8s/app/service.yaml

echo "Waiting for Ingress Controller pods to be ready..."
kubectl apply -f k8s/ingress.yaml
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=600s

echo "Setting up Cert-Manager secrets and issuer..."
kubectl apply -f k8s/cert-manager/letsencrypt-issuer.yaml
kubectl apply -f k8s/cert-manager/secrets.yaml

echo "Mattermost resources deployed successfully."
