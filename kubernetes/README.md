# Hello World Kubernetes Deployment

Este diretório contém os arquivos necessários para fazer o deploy da aplicação Hello World em um cluster Kubernetes com um Load Balancer no GCP.

## Arquivos

- `namespace.yaml`: Define o namespace `hello-world` para isolar a aplicação
- `configmap.yaml`: Armazena as configurações da aplicação (texto de saudação, cores)
- `deployment.yaml`: Gerencia os pods da aplicação com 3 réplicas e estratégia de atualização rolling
- `service.yaml`: Expõe a aplicação através de um Load Balancer no GCP
- `hpa.yaml`: Configura o escalonamento automático horizontal baseado em uso de CPU
- `deploy.sh`: Script para facilitar o deploy da aplicação

## Princípios Windsurf Aplicados

1. **Catch the Right Wind (Use Official & Minimal Base Images)**
   - Utilizamos a imagem oficial `josenetoalest/hello-world:v1.1` que é baseada em nginx:alpine

2. **Maintain Your Balance (Reproducible Builds)**
   - Versão específica da imagem (v1.1) para garantir consistência

3. **Ride the Wave Efficiently (Optimize Layers & Build Cache)**
   - Configuração de recursos otimizada (CPU/memória) para eficiência

4. **Be Agile & Responsive (Stateless & Configurable Containers)**
   - Configuração externalizada via ConfigMap
   - Aplicação stateless facilmente escalável

5. **Secure Your Gear (Container Security Best Practices)**
   - Execução como usuário não-root (UID 1000)
   - Probes de liveness e readiness para monitoramento de saúde
   - Limites de recursos definidos

## Como fazer o deploy

### Pré-requisitos

- Cluster Kubernetes GKE configurado
- `kubectl` instalado e configurado para acessar o cluster
- Permissões para criar recursos no GCP (Load Balancer)

### Instruções

1. Navegue até o diretório kubernetes:
   ```bash
   cd /Users/joseneto/demo-hello-world-app/kubernetes
   ```

2. Execute o script de deploy:
   ```bash
   ./deploy.sh
   ```

3. Aguarde até que o IP externo do Load Balancer seja atribuído (pode levar alguns minutos).

4. Acesse a aplicação através do IP externo no navegador.

### Verificando o status

```bash
# Verificar pods
kubectl -n hello-world get pods

# Verificar serviço e IP externo
kubectl -n hello-world get service hello-world

# Verificar logs
kubectl -n hello-world logs -l app=hello-world

# Verificar escalonamento automático
kubectl -n hello-world get hpa
```

## Limpeza

Para remover todos os recursos criados:

```bash
kubectl delete namespace hello-world
```
