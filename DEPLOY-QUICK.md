# Deploy Rápido - Hostinger VPS

## Passos Simples

### 1. Na sua VPS Hostinger via SSH:

\`\`\`bash
# Clone o repositório
git clone https://github.com/cesar59xxx/v0-sistemaqr.git
cd v0-sistemaqr

# Build e start com Docker
docker compose up -d --build

# Ver logs
docker compose logs -f
\`\`\`

### 2. Acessar a aplicação:

\`\`\`
http://SEU_IP_VPS:3000
\`\`\`

## Comandos Úteis

\`\`\`bash
# Parar a aplicação
docker compose down

# Rebuild após mudanças
git pull
docker compose up -d --build

# Ver logs
docker compose logs -f app

# Reiniciar
docker compose restart

# Status
docker compose ps
\`\`\`

## Solução de Problemas

### Build falha:
\`\`\`bash
# Limpar tudo e reconstruir
docker compose down -v
docker system prune -a -f
docker compose up -d --build
\`\`\`

### Porta 3000 já em uso:
\`\`\`bash
# Verificar o que está usando a porta
sudo lsof -i :3000

# Matar o processo
sudo kill -9 PID
\`\`\`

### Sem memória:
\`\`\`bash
# Verificar memória disponível
free -h

# Limpar cache do Docker
docker system prune -a -f
\`\`\`

## Configurar Domínio (Opcional)

### 1. Instalar Nginx:
\`\`\`bash
sudo apt update
sudo apt install nginx -y
\`\`\`

### 2. Criar configuração:
\`\`\`bash
sudo nano /etc/nginx/sites-available/whatsapp-saas
\`\`\`

\`\`\`nginx
server {
    listen 80;
    server_name seu-dominio.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
\`\`\`

### 3. Ativar e reiniciar:
\`\`\`bash
sudo ln -s /etc/nginx/sites-available/whatsapp-saas /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
\`\`\`

### 4. SSL com Certbot (HTTPS):
\`\`\`bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d seu-dominio.com
\`\`\`

## Credenciais Padrão

- Email: admin@admin.com
- Senha: admin123

**IMPORTANTE: Altere essas credenciais após o primeiro login!**
