-- ============================================================================
-- EXERCÍCIOS DE CONSULTAS AVANÇADAS - BANCO PAPELARIA
-- ============================================================================

USE papelaria;

-- ============================================================================
-- 1. Selecionar e mostrar na tela a lista de todos os clientes com respectivos 
--    pontos do programa de fidelidade em ordem decrescente. 
--    Não mostrar clientes que não possuam pontos.
-- ============================================================================

SELECT 
    id_cliente,
    nome,
    pontos_prog_fidelidade
FROM cliente
WHERE pontos_prog_fidelidade IS NOT NULL
ORDER BY pontos_prog_fidelidade DESC;


-- ============================================================================
-- 2. Mostrar a média de pontos do programa de fidelidade dos homens e das mulheres.
--    (genero: 0 = feminino, 1 = masculino)
-- ============================================================================

SELECT 
    CASE 
        WHEN genero = 0 THEN 'Feminino'
        WHEN genero = 1 THEN 'Masculino'
    END AS genero,
    AVG(pontos_prog_fidelidade) AS media_pontos
FROM cliente
WHERE pontos_prog_fidelidade IS NOT NULL
GROUP BY genero;


-- ============================================================================
-- 3. Exibir a quantidade de clientes cadastrados por ano.
-- ============================================================================

SELECT 
    ano_cadastro,
    COUNT(*) AS quantidade_clientes
FROM cliente
GROUP BY ano_cadastro
ORDER BY ano_cadastro;


-- ============================================================================
-- 4. Exibir a quantidade de clientes cadastrados por ano apenas para os anos 
--    entre 2005 e 2010.
-- ============================================================================

SELECT 
    ano_cadastro,
    COUNT(*) AS quantidade_clientes
FROM cliente
WHERE ano_cadastro BETWEEN 2005 AND 2010
GROUP BY ano_cadastro
ORDER BY ano_cadastro;


-- ============================================================================
-- 5. Mostrar a quantidade de produtos por id_fabricante.
-- ============================================================================

SELECT 
    id_fabricante,
    COUNT(*) AS quantidade_produtos
FROM produto
GROUP BY id_fabricante
ORDER BY id_fabricante;


-- ============================================================================
-- 6. Mostrar as quantidades de itens vendidos em cada venda.
-- ============================================================================

SELECT 
    id_venda,
    SUM(qtde) AS total_itens
FROM item_venda
GROUP BY id_venda
ORDER BY id_venda;


-- ============================================================================
-- 7. Exibir os possíveis percentuais de comissão que um vendedor pode receber.
-- ============================================================================

SELECT DISTINCT 
    percentual_comissao
FROM vendedor
WHERE percentual_comissao IS NOT NULL
ORDER BY percentual_comissao;


-- ============================================================================
-- 8. Mostrar os id's de fabricantes que já forneceram produtos para a papelaria.
-- ============================================================================

SELECT DISTINCT 
    id_fabricante
FROM produto
ORDER BY id_fabricante;


-- ============================================================================
-- 9. Exibir os produtos com as respectivas quantidades em estoque em ordem 
--    decrescente da quantidade.
-- ============================================================================

SELECT 
    id_produto,
    descricao,
    qtde_estoque
FROM produto
ORDER BY qtde_estoque DESC;


-- ============================================================================
-- 10. Apresentar quantos vendedores do gênero feminino estão cadastrados.
--     (genero: 0 = feminino)
-- ============================================================================

SELECT 
    COUNT(*) AS total_vendedoras
FROM vendedor
WHERE genero = 0;


-- ============================================================================
-- 11. Apresentar quantos vendedores do gênero feminino possuem salário maior 
--     que R$ 1500,00.
-- ============================================================================

SELECT 
    COUNT(*) AS total_vendedoras_salario_alto
FROM vendedor
WHERE genero = 0 
  AND salario > 1500;


-- ============================================================================
-- BÔNUS: Query para ver todas as vendedoras com salário > 1500
-- ============================================================================

SELECT 
    id_vendedor,
    nome,
    salario
FROM vendedor
WHERE genero = 0 
  AND salario > 1500;


-- ============================================================================
-- 12. Crie uma consulta que apresente como resultado a lista dos produtos 
--     cujo valor seja maior que R$ 100,00 seguido da quantidade em estoque. 
--     O resultado deve ser apresentado conforme a seguir:
--     "O produto xxxx possui yyyy unidades em estoque".
-- ============================================================================

SELECT 
    CONCAT('O produto ', descricao, ' possui ', qtde_estoque, ' unidades em estoque') AS informacao
FROM produto
WHERE valor > 100
ORDER BY descricao;
