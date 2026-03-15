-- Relatório 5: Rastreabilidade de Pneus com Subconsulta

-- Descrição: Mostra quais veículos já tiveram pneus trocados e registrados no sistema, 
-- exibindo o total de pneus por veículo e a data da última troca.

-- Requisito Atendido: Utiliza consulta aninhada (Subquery) no SELECT e funções de agregação (MAX).

SELECT 
    v.placa, 
    v.modelo,
    (SELECT COUNT(*) FROM gh_pneus p WHERE p.veiculo_id = v.id) AS total_pneus_registrados,
    MAX(pn.data_instalacao) AS ultima_troca
FROM gh_veiculos v
INNER JOIN gh_pneus pn ON v.id = pn.veiculo_id
GROUP BY v.placa, v.modelo
HAVING total_pneus_registrados > 0;