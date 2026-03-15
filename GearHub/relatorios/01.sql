-- Relatório 1: Visão Geral da Frota por Empresa e Sede

-- Descrição: Este relatório mapeia a distribuição dos veículos do GearHub. 
-- Ele retorna o nome da empresa, a sede (filial), e agrega o total de veículos e a capacidade total de combustível armazenada naquela sede.

-- Requisito Atendido: Utiliza JOIN entre 3 tabelas (gh_empresas, gh_sedes, gh_veiculos) e funções de agregação (COUNT, SUM).

SELECT 
    e.nome AS empresa, 
    s.nome AS filial, 
    s.endereco,
    COUNT(v.id) AS total_veiculos,
    SUM(v.capacidade_tanque_litros) AS capacidade_total_combustivel
FROM gh_empresas e
INNER JOIN gh_sedes s ON e.id = s.empresa_id
LEFT JOIN gh_veiculos v ON s.id = v.sede_id
GROUP BY e.nome, s.nome, s.endereco
ORDER BY total_veiculos DESC;