# Guia de Troubleshooting - Deploy na Hostinger

## Problema: Build falha no Docker

### Solução 1: Usar Dockerfile Simplificado

Se o build está falando, use o Dockerfile simplificado para ver mais detalhes do erro:

\`\`\`bash
# Na VPS da Hostinger
docker compose -f docker-compose.debug.yml up --build
\`\`\`

Isso mostrará todos os logs detalhados do build.

### Solução 2: Build Local Primeiro

Teste o build localmente antes de enviar para a VPS:

\`\`\`bash
# No seu computador
npm install
npm run build
\`\`\`

Se falhar localmente, você verá o erro exato.

### Solução 3: Verificar Logs Completos

Para ver logs completos do build no Docker:

\`\`\`bash
# Build sem cache
docker compose build --no-cache --progress=plain

# Ver logs detalhados
docker compose logs -f
\`\`\`

### Solução 4: Limpar Cache do Docker

Às vezes o cache do Docker causa problemas:

\`\`\`bash
# Limpar tudo
docker system prune -a
docker volume prune

# Rebuild
docker compose up --build
\`\`\`

## Problema: Porta 3000 já em uso

\`\`\`bash
# Encontrar processo usando a porta
lsof -i :3000

# Matar processo
kill -9 <PID>

# Ou parar todos os containers
docker compose down
\`\`\`

## Problema: Permissões Negadas

\`\`\`bash
# Dar permissões ao usuário
sudo usermod -aG docker $USER

# Relogar ou
newgrp docker
\`\`\`

## Problema: Memória Insuficiente

Se o build falha por falta de memória:

\`\`\`bash
# Aumentar swap temporariamente
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
\`\`\`

## Problema: Build Muito Lento

Use o Dockerfile.simple que é mais rápido para desenvolvimento:

\`\`\`bash
docker compose -f docker-compose.debug.yml up --build
\`\`\`

## Problema: Erro de Rede/DNS

\`\`\`bash
# Reiniciar serviço Docker
sudo systemctl restart docker

# Verificar DNS
ping google.com
\`\`\`

## Verificar Status da Aplicação

\`\`\`bash
# Ver containers rodando
docker ps

# Ver logs
docker compose logs -f

# Entrar no container
docker compose exec app sh

# Verificar se o app está respondendo
curl http://localhost:3000/api/health
\`\`\`

## Deploy Passo a Passo Completo

1. **Clone o repositório**
\`\`\`bash
cd ~
git clone https://github.com/seu-usuario/seu-repo.git
cd seu-repo
\`\`\`

2. **Teste build local (opcional)**
\`\`\`bash
docker compose -f docker-compose.debug.yml build
\`\`\`

3. **Suba a aplicação**
\`\`\`bash
docker compose up -d
\`\`\`

4. **Verifique os logs**
\`\`\`bash
docker compose logs -f
\`\`\`

5. **Teste a aplicação**
\`\`\`bash
curl http://localhost:3000
\`\`\`

6. **Configure Nginx (se necessário)**
Veja o arquivo DEPLOY.md para configuração completa do Nginx.

## Comandos Úteis

\`\`\`bash
# Parar aplicação
docker compose down

# Atualizar aplicação
git pull
docker compose up -d --build

# Ver uso de recursos
docker stats

# Limpar logs
docker compose logs --tail=100

# Backup dos dados (se tiver volumes)
docker compose exec app tar czf /tmp/backup.tar.gz /app/data
\`\`\`

## Contato de Suporte

Se nenhuma solução funcionar:
1. Copie os logs completos: `docker compose logs > logs.txt`
2. Verifique a versão do Docker: `docker --version`
3. Verifique recursos disponíveis: `free -h` e `df -h`
