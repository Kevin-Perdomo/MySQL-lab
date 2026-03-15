-- Relatório 2: Status Operacional de Documentação

-- Descrição: Retorna a placa e o modelo dos veículos junto com os dados dos seus documentos. 
-- Cria uma nova coluna classificando a gravidade da situação do documento de forma amigável para o gestor.

-- Requisito Atendido: Utiliza JOIN e CASE WHEN para criar regras de negócio na exibição.

SELECT 
    v.placa, 
    v.marca, 
    v.modelo,
    d.tipo_documento,
    d.ano_referencia,
    CASE 
        WHEN d.status = 'Pago' THEN 'Regular'
        WHEN d.status = 'Vencido' THEN 'Urgente - Risco de Apreensão'
        WHEN d.status = 'Pendente' THEN 'Atenção - Prazo Correndo'
        ELSE 'Sem Informação'
    END AS situacao_operacional
FROM gh_veiculos v
LEFT JOIN gh_documentos d ON v.id = d.veiculo_id
ORDER BY situacao_operacional DESC, v.placa;