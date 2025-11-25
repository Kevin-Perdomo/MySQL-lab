-- 1- Mostrar os nomes dos clientes que já fizeram compras na papelaria
SELECT DISTINCT c.nome
FROM cliente c
JOIN venda v ON c.id_cliente = v.id_cliente;

-- 2- Mostrar a quantidade de vendas realizadas por vendedor em ordem decrescente
SELECT 
    vd.nome AS Vendedor,
    COUNT(v.id_venda) AS Quantidade_Vendas
FROM vendedor vd
LEFT JOIN venda v 
ON vd.id_vendedor = v.id_vendedor
GROUP BY vd.id_vendedor, vd.nome
ORDER BY Quantidade_Vendas DESC;

-- 3- Exibir uma lista de todos os produtos com os respectivos fabricantes
SELECT 
    p.descricao AS Produto,
    f.descricao AS Fabricante
FROM produto p
JOIN fabricante f 
ON p.id_fabricante = f.id_fabricante;

-- 4- Mostrar os nomes dos clientes que fizeram compras no ano de 2011
SELECT DISTINCT c.nome
FROM cliente c
JOIN venda v 
ON c.id_cliente = v.id_cliente
WHERE v.ano = 2011;

-- 5- Listar dados das vendas feitas com o respectivo nome do vendedor.
-- Mesmo os vendedores que nunca venderam nada devem ser mostrados
SELECT 
    vd.nome AS Vendedor,
    v.id_venda,
    v.ano,
    v.mes
FROM vendedor vd
LEFT JOIN venda v 
ON vd.id_vendedor = v.id_vendedor;

-- 6- Exibir lista de TODOS os vendedores com a cidade onde moram
SELECT 
    vd.nome AS Vendedor,
    cid.descricao AS Cidade
FROM vendedor vd
LEFT JOIN cidade cid 
ON vd.id_cidade = cid.id_cidade;

-- 7- Exibir a descrição e id do produto mais barato
SELECT 
    id_produto,
    descricao,
    valor
FROM produto
WHERE valor = (SELECT MIN(valor) FROM produto);

-- 8- Exibir descrições e id's dos produtos que têm valor maior que a média
-- de valores dos produtos em ordem decrescente de valor
SELECT 
    id_produto,
    descricao,
    valor
FROM produto
WHERE valor > (SELECT AVG(valor) FROM produto)
ORDER BY valor DESC;

-- DESAFIO 1:
SELECT DISTINCT
    vd.nome AS Vendedor,
    p.descricao AS Produto
FROM vendedor vd
JOIN venda v ON vd.id_vendedor = v.id_vendedor
JOIN item_venda iv ON v.id_venda = iv.id_venda
JOIN produto p ON iv.id_produto = p.id_produto
ORDER BY vd.nome DESC;

-- DESAFIO 2:
SELECT 
    vd.nome AS Vendedor,
    SUM(iv.qtde) AS Quantidade_Total_Vendida
FROM vendedor vd
JOIN venda v ON vd.id_vendedor = v.id_vendedor
JOIN item_venda iv ON v.id_venda = iv.id_venda
GROUP BY vd.id_vendedor, vd.nome
ORDER BY Quantidade_Total_Vendida DESC;

-- DESAFIO 3:
SELECT DISTINCT
    vd.nome AS Vendedor,
    p.descricao AS Produto
FROM produto p
LEFT JOIN item_venda iv ON p.id_produto = iv.id_produto
LEFT JOIN venda v ON iv.id_venda = v.id_venda
LEFT JOIN vendedor vd ON v.id_vendedor = vd.id_vendedor
ORDER BY vd.nome DESC;

-- DESAFIO 4:
SELECT DISTINCT
    c.nome AS Cliente,
    f.descricao AS Fabricante
FROM cliente c
JOIN venda v ON c.id_cliente = v.id_cliente
JOIN item_venda iv ON v.id_venda = iv.id_venda
JOIN produto p ON iv.id_produto = p.id_produto
JOIN fabricante f ON p.id_fabricante = f.id_fabricante
ORDER BY c.nome, f.descricao;