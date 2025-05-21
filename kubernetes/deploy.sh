#!/bin/bash
# Script para fazer deploy da aplicação hello-world no Kubernetes

echo "Iniciando deploy da aplicação hello-world no Kubernetes..."

# Aplicar namespace
echo "Criando namespace..."
kubectl apply -f namespace.yaml

# Aplicar ConfigMap
echo "Aplicando ConfigMap..."
kubectl apply -f configmap.yaml

# Aplicar Deployment
echo "Aplicando Deployment..."
kubectl apply -f deployment.yaml

# Aplicar Service (LoadBalancer)
echo "Aplicando Service (LoadBalancer)..."
kubectl apply -f service.yaml

# Aplicar HPA
echo "Aplicando HorizontalPodAutoscaler..."
kubectl apply -f hpa.yaml

# Verificar status do deployment
echo "Verificando status do deployment..."
kubectl -n hello-world rollout status deployment/hello-world

# Obter o IP externo do LoadBalancer (pode levar alguns minutos para ser atribuído)
echo "Aguardando IP externo do LoadBalancer (pode levar alguns minutos)..."
kubectl -n hello-world get service hello-world -w
