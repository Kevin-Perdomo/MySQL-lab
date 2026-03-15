-- Atualizar status baseado em regras de negócio

UPDATE gh_documentos
SET status = CASE 
    WHEN data_pagamento IS NOT NULL THEN 'Regularizado'
    WHEN data_pagamento IS NULL AND ano_referencia < YEAR(CURDATE()) THEN 'Atrasado'
    ELSE 'Pendente'
END;