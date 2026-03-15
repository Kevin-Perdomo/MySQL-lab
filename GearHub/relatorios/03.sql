-- Relatório 3: Auditoria de Garantia de Baterias

-- Descrição: Lista todas as baterias instaladas na frota, vinculando-as aos veículos. 
-- Calcula dinamicamente se a bateria ainda está na garantia com base na data atual do sistema.


-- Requisito Atendido: Utiliza JOIN, funções de data (CURDATE()) e CASE WHEN.

SELECT 
    v.placa,
    b.marca AS marca_bateria,
    b.data_instalacao,
    b.fim_garantia,
    CASE 
        WHEN b.fim_garantia >= CURDATE() THEN 'Na Garantia'
        ELSE 'Garantia Expirada'
    END AS status_garantia
FROM gh_baterias b
INNER JOIN gh_veiculos v ON b.veiculo_id = v.id
ORDER BY b.fim_garantia ASC;