-- Esta PROCEDURE permite que o mecânico registre a troca de óleo informando apenas a placa do veículo, sem precisar saber o id interno do banco de dados. 
-- A PROCEDURE irá buscar o id do veículo com base na placa fornecida e registrar a troca de óleo com os dados informados.

DELIMITER //

CREATE PROCEDURE sp_registrar_troca_oleo(
    IN p_placa CHAR(7),
    IN p_tipo_oleo VARCHAR(100),
    IN p_km INT,
    IN p_trocou_filtro BIT(1)
)
BEGIN
    DECLARE v_id BIGINT;

    -- Busca o ID interno do veículo usando a placa informada
    SELECT id INTO v_id FROM gh_veiculos WHERE placa = p_placa;

    -- Insere a nova troca de óleo com a data atual (CURDATE)
    INSERT INTO gh_oleos (veiculo_id, tipo_oleo, quilometragem, data_troca, trocou_filtro)
    VALUES (v_id, p_tipo_oleo, p_km, CURDATE(), p_trocou_filtro);
    
END //

DELIMITER ;