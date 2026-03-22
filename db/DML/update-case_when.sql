-- Atualizar status baseado em regras de negócio

-- Regras:
-- 1. Se a data de pagamento for preenchida, o status é 'Regularizado'.
-- 2. Se a data de pagamento for nula e o ano de referência for menor que o ano atual, o status é 'Atrasado'.
-- 3. Caso contrário, o status é 'Pendente'.    

UPDATE gh_documentos
SET status = CASE 
    WHEN data_pagamento IS NOT NULL THEN 'Regularizado'
    WHEN data_pagamento IS NULL AND ano_referencia < YEAR(CURDATE()) THEN 'Atrasado'
    ELSE 'Pendente'
END;