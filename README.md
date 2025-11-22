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
docker exec -i mysql-abd mysql -uroot -proot123 < src/GearHub/db/ddl.sql
```

### Para verificar se o banco foi criado:

```bash
docker exec -it mysql-abd mysql -uroot -proot123 -e "SHOW DATABASES;"
```

```bash
docker exec -it mysql-abd mysql -uroot -proot123 gearhub -e "SHOW TABLES;"
```

## 🗄️ Persistência de dados

Os dados do MySQL são persistidos em um volume Docker chamado `mysql_data`. Isso significa que:

- Os dados permanecem mesmo se você parar o container
- Para resetar completamente, use `docker-compose down -v`
