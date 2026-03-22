-- Data Query Language (DQL) for GearHub Database

-- Relatório 4: Qualidade das Manutenções de Óleo

-- Descrição: Traz o histórico de trocas de óleo. 
-- Para facilitar a leitura do mecânico, converte o valor booleano (0 ou 1) do banco em uma mensagem de texto explicativa sobre a troca do filtro.

-- Requisito Atendido: Utiliza JOIN e CASE WHEN para transformação de dados booleanos.

SELECT 
    v.placa,
    o.data_troca,
    o.quilometragem,
    o.tipo_oleo,
    CASE 
        WHEN o.trocou_filtro = 1 THEN 'Completa (Óleo + Filtro)'
        ELSE 'Incompleta (Apenas Óleo - Risco ao Motor)'
    END AS qualidade_manutencao
FROM gh_oleos o
INNER JOIN gh_veiculos v ON o.veiculo_id = v.id
ORDER BY o.data_troca DESC;