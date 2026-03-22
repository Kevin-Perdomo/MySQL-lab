-- Data Control Language (DCL) for GearHub Database

-- 1. Usuário Admin (Todas as permissões)
CREATE USER 'admin_gh'@'localhost' IDENTIFIED BY 'SenhaAdmin123!';
GRANT ALL PRIVILEGES ON gearhub.* TO 'admin_gh'@'localhost';

-- 2. Usuário Operacional (Acesso apenas a 3 tabelas: empresas, sedes e veiculos)
CREATE USER 'operador_gh'@'localhost' IDENTIFIED BY 'SenhaOperador123!';
GRANT SELECT, INSERT, UPDATE ON gearhub.gh_empresas TO 'operador_gh'@'localhost';
GRANT SELECT, INSERT, UPDATE ON gearhub.gh_sedes TO 'operador_gh'@'localhost';
GRANT SELECT, INSERT, UPDATE ON gearhub.gh_veiculos TO 'operador_gh'@'localhost';

-- 3. Usuário Restrito (Acesso apenas a algumas colunas de gh_veiculos)
CREATE USER 'mecanico_gh'@'localhost' IDENTIFIED BY 'SenhaMecanico123!';
GRANT SELECT (placa, marca, modelo, ano_modelo) ON gearhub.gh_veiculos TO 'mecanico_gh'@'localhost';
GRANT UPDATE (descricao) ON gearhub.gh_veiculos TO 'mecanico_gh'@'localhost';

-- 4. Usuário de Auditoria (Permissão extra: Somente visualização de todo o banco)
CREATE USER 'auditor_gh'@'localhost' IDENTIFIED BY 'SenhaAuditor123!';
GRANT SELECT ON gearhub.* TO 'auditor_gh'@'localhost';

-- Aplicar as mudanças
FLUSH PRIVILEGES;