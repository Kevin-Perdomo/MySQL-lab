--  Toda vez que alguém atualizar um documento no GearHub e preencher a data de pagamento, 
--  a Trigger vai interceptar essa ação e mudar o status para 'Regularizado' sozinha, antes mesmo de salvar o banco.

DELIMITER //

CREATE TRIGGER trg_baixa_automatica_documento
BEFORE UPDATE ON gh_documentos
FOR EACH ROW
BEGIN
    -- Se o documento não tinha data de pagamento e agora está recebendo uma
    IF OLD.data_pagamento IS NULL AND NEW.data_pagamento IS NOT NULL THEN
        -- O banco altera o status automaticamente para 'Regularizado'
        SET NEW.status = 'Regularizado';
    END IF;
END //

DELIMITER ;