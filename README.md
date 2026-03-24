# MySQL-lab

![Logo](images/logo.png)

## 📑 Índice

- [Sobre](#-sobre)
- [Pré-requisitos](#-pré-requisitos)
- [Container](#-container)
- [Conectar ao MySQL](#-conectar-ao-mysql)
- [Banco de Dados GearHub](#-banco-de-dados-gearhub)
- [Permissões (DCL)](#-permissões-dcl)
- [Rotinas](#️-rotinas)
- [Backup](#-backup)

---

## 📚 Sobre

Repositório criado para facilitar o aprendizado durante as aulas de **Administração de Banco de Dados**. Ambiente MySQL completo via Docker, pronto para:

- 🎯 Aprender e praticar conceitos de SQL
- 💡 Experimentar com consultas avançadas
- 🔧 Manipular bancos de dados sem configurações complexas
- 📊 Desenvolver habilidades em administração de bancos de dados
- 🚀 Trabalhar em projetos acadêmicos e exercícios práticos

---

## 📋 Pré-requisitos

- Linux
- Docker
- Docker Compose

---

## 🐳 Container

MySQL 8.0 configurado para desenvolvimento e aprendizado.

| Configuração  | Valor   |
|---------------|---------|
| Porta         | 3306    |
| Usuário       | root    |
| Senha         | root123 |
| Banco inicial | aula_db |

### Gerenciar o container

```bash
# Iniciar
docker compose up -d

# Parar
docker compose down

# Parar e remover dados (reiniciar do zero)
docker compose down -v
```

> Os dados são persistidos no volume `mysql_data` e sobrevivem a reinicializações normais.

### Logs e status

```bash
docker compose logs -f
docker compose ps
```

---

## 🔌 Conectar ao MySQL

### Via terminal

```bash
# Conectar ao MySQL
docker exec -it mysql-abd mysql -uroot -proot123

# Conectar diretamente a um banco específico
docker exec -it mysql-abd mysql -uroot -proot123 aula_db
docker exec -it mysql-abd mysql -uroot -proot123 gearhub
docker exec -it mysql-abd mysql -uroot -proot123 papelaria

# Conectar pedindo senha interativamente (mais seguro)
docker exec -it mysql-abd mysql -uroot -p

# Executar comando SQL direto
docker exec -it mysql-abd mysql -uroot -proot123 -e "SHOW DATABASES;"
```

### Via cliente externo

| Campo    | Valor     |
|----------|-----------|
| Host     | localhost |
| Porta    | 3306      |
| Usuário  | root      |
| Senha    | root123   |
| Database | aula_db   |

Ferramentas recomendadas: MySQL Workbench, DBeaver, phpMyAdmin, DataGrip

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

---

## 📦 Banco de Dados GearHub

Sistema de Gestão de Veículos.

### Inicialização rápida

```bash
chmod +x init_db.sh
./init_db.sh
```

### Inicialização manual (passo a passo)

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

---

## 🔐 Permissões (DCL)

```sql
-- Ver permissões do Operador (deve mostrar acesso às 3 tabelas)
SHOW GRANTS FOR 'operador_gh'@'localhost';

-- Ver permissões do Mecânico (deve mostrar acesso apenas a colunas específicas)
SHOW GRANTS FOR 'mecanico_gh'@'localhost';

-- Ver permissões do Auditor (deve mostrar acesso de leitura a tudo)
SHOW GRANTS FOR 'auditor_gh'@'localhost';

-- Ver permissões do Admin (deve mostrar ALL PRIVILEGES)
SHOW GRANTS FOR 'admin_gh'@'localhost';
```

---

## ⚙️ Rotinas

### Trigger — Regularização automática de documentos

```sql
-- 1. Veja como está o documento de ID 1 (status deve estar 'Atrasado' e data_pagamento NULL)
SELECT id, tipo_documento, status, data_pagamento FROM gh_documentos WHERE id = 1;

-- 2. Faça o UPDATE apenas da data (simulando o pagamento hoje)
UPDATE gh_documentos SET data_pagamento = CURDATE() WHERE id = 1;

-- 3. Veja a trigger em ação (status alterado automaticamente para 'Regularizado')
SELECT id, tipo_documento, status, data_pagamento FROM gh_documentos WHERE id = 1;
```

### Function — Garantia da bateria

```sql
-- Lista a marca e quantos dias faltam para vencer a garantia da bateria
SELECT marca, fn_dias_garantia_bateria(fim_garantia) AS dias_para_vencer FROM gh_baterias;
```

### Procedure — Troca de óleo

```sql
-- 1. Verifique o ultimo registro antes da chamada da procedure
SELECT * FROM gh_oleos ORDER BY id DESC;

-- 2. Chame a procedure para registrar uma nova troca de oleo
CALL sp_registrar_troca_oleo('KRA1234', '15W40 Sintetico', 65000, 1);

-- 3. Verifique novamente para confirmar o novo registro
SELECT * FROM gh_oleos ORDER BY id DESC;
```

---

## 💾 Backup

```bash
# Criar backup
chmod +x backup/backup.sh
./backup/backup.sh

# Restaurar backup
docker exec -i mysql-abd mysql -uroot -proot123 gearhub < backup/dumps/NOME_DO_ARQUIVO.sql
```
