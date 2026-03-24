#!/bin/bash

# Configurações do Banco de Dados
DB_USER="admin_gh"
DB_PASS="SenhaAdmin123!"
DB_NAME="gearhub"
CONTAINER_NAME="mysql-abd"

# Descobre dinamicamente o diretório onde este script está salvo
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Define a pasta dumps dentro do diretório do script
BACKUP_DIR="$BASE_DIR/dumps"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"

# Cria o diretório de dumps caso não exista
mkdir -p "$BACKUP_DIR"

# Executa o mysqldump DENTRO do Docker e salva no arquivo no Ubuntu
docker exec "$CONTAINER_NAME" mysqldump --no-tablespaces -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"

# Verifica se o comando do docker funcionou antes de dar a mensagem de sucesso
if [ $? -eq 0 ]; then
    # Limpeza: Deleta backups mais antigos que 7 dias para poupar disco
    find "$BACKUP_DIR" -type f -name "*.sql" -mtime +7 -exec rm {} \;
    echo "✅ Backup do banco $DB_NAME realizado com sucesso em: $BACKUP_FILE"
else
    echo "❌ Erro ao gerar o backup. Verifique se o container '$CONTAINER_NAME' está rodando."
    # Remove o arquivo vazio gerado pela falha
    rm "$BACKUP_FILE"
fi