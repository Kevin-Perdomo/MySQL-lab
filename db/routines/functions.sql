-- Esta FUNCTION recebe a data de fim da garantia de uma bateria e calcula, em tempo real, quantos dias faltam para ela expirar. 
-- Se a garantia já tiver expirado, a função retorna um valor negativo indicando quantos dias se passaram desde o vencimento.

DELIMITER //

CREATE FUNCTION fn_dias_garantia_bateria(data_fim_garantia DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE dias_restantes INT;
    
    -- Calcula a diferença em dias entre o fim da garantia e a data de hoje
    SET dias_restantes = DATEDIFF(data_fim_garantia, CURDATE());
    
    RETURN dias_restantes;
END //

DELIMITER ;