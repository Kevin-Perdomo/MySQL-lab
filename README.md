# MySQL-lab

![Logo](images/logo.png)

## 📚 Sobre o Repositório

Este repositório foi criado para facilitar o aprendizado e a prática durante as aulas de **Administração de Banco de Dados**. Aqui você encontrará um ambiente MySQL completo configurado via Docker, pronto para ser usado como laboratório para:

- 🎯 Aprender e praticar conceitos de SQL
- 💡 Experimentar com consultas avançadas
- 🔧 Manipular bancos de dados sem configurações complexas
- 📊 Desenvolver habilidades em administração de bancos de dados
- 🚀 Trabalhar em projetos acadêmicos e exercícios práticos

---

## 🐳 Sobre o Container

Este projeto contém um container Docker com MySQL 8.0 configurado e pronto para uso em ambiente de desenvolvimento e aprendizado.

## 📋 Pré-requisitos

- Docker instalado
- Docker Compose instalado

## 🚀 Como usar

### Iniciar o container

```bash
docker compose up -d
```

### Parar o container

```bash
docker compose down
```

### Parar e remover os dados (reiniciar do zero)
Os dados do MySQL são persistidos em um volume Docker chamado `mysql_data`. Isso significa que:

- Os dados permanecem mesmo se você parar o container
- Para resetar completamente:

```bash
docker compose down -v
```

## 🔧 Configurações

- **Porta:** 3306
- **Usuário:** root
- **Senha:** root123
- **Banco de dados inicial:** aula_db

## 📊 Conectar ao MySQL

### Via linha de comando (fora do container)

```bash
# Conectar ao MySQL
docker exec -it mysql-abd mysql -uroot -proot123

# Conectar diretamente a um banco específico
docker exec -it mysql-abd mysql -uroot -proot123 aula_db
docker exec -it mysql-abd mysql -uroot -proot123 gearhub
docker exec -it mysql-abd mysql -uroot -proot123 papelaria

# Conectar pedindo senha interativamente (mais seguro)
docker exec -it mysql-abd mysql -uroot -p
```

### Comandos úteis dentro do MySQL

```sql
-- Ver todos os bancos de dados
SHOW DATABASES;

-- Usar/entrar em um banco específico
USE aula_db;
USE gearhub;
USE papelaria;

-- Ver qual banco está sendo usado
SELECT DATABASE();

-- Ver todas as tabelas do banco atual
SHOW TABLES;

-- Descrever estrutura de uma tabela
DESCRIBE nome_da_tabela;

-- Ver informações sobre colunas de uma tabela
SHOW COLUMNS FROM nome_da_tabela;

-- Ver comando CREATE de uma tabela
SHOW CREATE TABLE nome_da_tabela;

-- Sair do MySQL
exit;
-- ou pressione Ctrl+D
```

### Via cliente MySQL externo

- **Host:** localhost
- **Porta:** 3306
- **Usuário:** root
- **Senha:** root123
- **Database:** aula_db

### Ferramentas recomendadas

- MySQL Workbench
- DBeaver
- phpMyAdmin
- DataGrip

## 💡 Comandos úteis

### Ver logs do container

```bash
docker compose logs -f
```

### Verificar status do container

```bash
docker compose ps
```

### Executar comandos SQL diretamente

```bash
docker exec -it mysql-abd mysql -uroot -proot123 -e "SHOW DATABASES;"
```

## 📦 Importar banco de dados de exemplo

### 🚗 GearHub - Sistema de Gestão de Veículos

#### Criar o banco de dados GearHub:

```bash
# 1. Criar estrutura (DDL)
docker exec -i mysql-abd mysql -uroot -proot123 < db/DDL/schema.sql

# 2. Inserir dados (DML)
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/DML/inserts.sql

# 3. Atualizar status (CASE WHEN)
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/DML/update-case_when.sql

# 4. Criar índices para otimizar buscas e joins
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/DDL/indices.sql

# 5. Criar usuários e aplicar permissões (DCL)
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/DCL/permissions.sql

# 6. Criar triggers (rotinas)
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/routines/triggers.sql

# 7. Criar procedures (rotinas)
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/routines/procedures.sql

# 8. Criar functions (rotinas)
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < db/routines/functions.sql

```

### Para verificar as permissões criadas:

```bash
# Ver permissões do Operador (deve mostrar acesso às 3 tabelas)
SHOW GRANTS FOR 'operador_gh'@'localhost';

# Ver permissões do Mecânico (deve mostrar acesso apenas a colunas específicas)
SHOW GRANTS FOR 'mecanico_gh'@'localhost';

# Ver permissões do Auditor (deve mostrar acesso de leitura a tudo)
SHOW GRANTS FOR 'auditor_gh'@'localhost';

# Ver permissões do Admin (deve mostrar ALL PRIVILEGES)
SHOW GRANTS FOR 'admin_gh'@'localhost';
```

### Para verificar a trigger de regularização automática:

```sql
-- 1. Veja como está o documento de ID 1 (status deve estar 'Pendente' e data_pagamento NULL)
SELECT id, tipo_documento, status, data_pagamento FROM gh_documentos WHERE id = 1;

-- 2. Faça o UPDATE apenas da data (simulando o pagamento hoje)
UPDATE gh_documentos SET data_pagamento = CURDATE() WHERE id = 1;

-- 3. Veja a trigger em ação (status alterado automaticamente para 'Regularizado')
SELECT id, tipo_documento, status, data_pagamento FROM gh_documentos WHERE id = 1;
```

### Para verificar a function de garantia da bateria:

```sql
-- Lista a marca e quantos dias faltam para vencer a garantia da bateria
SELECT marca, fn_dias_garantia_bateria(fim_garantia) AS dias_para_vencer FROM gh_baterias;
```

### Para verificar a procedure de registro de troca de oleo:

```sql
-- 1. Verifique o ultimo registro antes da chamada da procedure
SELECT * FROM gh_oleos ORDER BY id DESC;

-- 2. Chame a procedure para registrar uma nova troca de oleo
CALL sp_registrar_troca_oleo('KRA1234', '15W40 Sintetico', 65000, 1);

-- 3. Verifique novamente para confirmar o novo registro
SELECT * FROM gh_oleos ORDER BY id DESC;
```
### Inicializar o Banco de Dados do Zero (`init_db.sh`)
Para rodar a configuração inicial com Docker, executando DDL, DML, DCL e rotinas:

```bash
chmod +x init_db.sh
./init_db.sh
```

### Criar um Backup (`backup.sh`)
```bash
chmod +x backup/backup.sh
./backup/backup.sh
```

### Restaurar um Backup
```bash
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < backup/dumps/NOME_DO_ARQUIVO.sql
```