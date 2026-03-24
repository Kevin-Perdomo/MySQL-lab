#!/bin/bash

echo "🚗 Iniciando a configuração do banco de dados GearHub no Docker..."

# 1. Criar estrutura (DDL)
echo "-> Criando tabelas e relacionamentos..."
docker exec -i mysql-abd mysql -uroot -proot123 < db/DDL/schema.sql

# 2. Inserir dados (DML)
echo "-> Inserindo dados de teste..."
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/DML/inserts.sql

# 3. Atualizar status (CASE WHEN)
echo "-> Atualizando status dos documentos..."
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/DML/update-case_when.sql

# 4. Criar índices para otimizar buscas e joins
echo "-> Criando índices..."
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/DDL/indices.sql

# 5. Criar usuários e aplicar permissões (DCL)
echo "-> Configurando controle de acesso..."
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/DCL/permissions.sql

# 6. Criar rotinas
echo "-> Criando Triggers, Procedures e Functions..."
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/routines/triggers.sql
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/routines/procedures.sql
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/routines/functions.sql

echo "✅ GearHub configurado com sucesso! O banco está pronto para uso."