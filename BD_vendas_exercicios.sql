-- LISTA DE EXERCÍCIOS - SQL

-- Listar todos os produtos com as respectivas descrições, unidades e valores unitários, obtendo o seguinte resultado:

SELECT descricao, unidade, valor_unitario 
FROM produtos;

SELECT * FROM produtos;

SELECT descricao, valor_unitario 
FROM produtos;

-- Listar todo o conteúdo de vendedor, obtendo o seguinte resultado, usando *:

SELECT * FROM vendedores;

-- Listar da tabela CLIENTE o CNPJ, o nome do cliente e seu endereço, obtendo o seguinte resultado:

SELECT cnpj, nome, endereco
FROM clientes;

-- Listar todas as cidades em que há clientes

SELECT cidade
FROM clientes;

SELECT DISTINCT cidade
FROM clientes;

-- Listar todas as cidades e estados em que há clientes

SELECT cidade, uf
FROM clientes;

SELECT DISTINCT cidade, uf
FROM clientes;

-- Quais são os clientes que moram em Niterói?

SELECT nome, cidade
FROM clientes
WHERE cidade = "Niterói";

/* WHERE cidade = "Niterói" || cidade = "Brasília"; */
/* WHERE cidade = "Niterói" OR cidade = "Brasília"; */
/* WHERE cidade = "Niterói" && nome = "Ana"; */
/* WHERE cidade = "Niterói" AND nome = "Ana"; */

-- Listar os produtos que tenham unidade igual a ‘M’ e valor unitário igual a R$ 1,05 da tabela produto:

SELECT descricao, unidade, valor_unitario
FROM produtos
WHERE unidade = 'M' AND valor_unitario = 1.05;

-- Listar o código, a descrição e o valor unitario dos produtos que tenham o valor unitário na faixa de R$ 0,32 até R$ 2,00:

SELECT id, descricao, valor_unitario
FROM produtos
WHERE valor_unitario BETWEEN 0.32 AND 2.00; 

-- Listar oo código, a descrição e o valor unitario dos produtos que NÃO tenham o valor unitário na faixa de R$ 0,32 até R$ 2,00:

SELECT id, descricao, valor_unitario
FROM produtos
WHERE NOT valor_unitario BETWEEN 0.32 AND 2.00;

-- Listar os nomes entre Ana e Jorge

SELECT nome 
FROM clientes
WHERE nome BETWEEN "Ana" AND "Jorge"
ORDER BY nome;

-- Listar Listar os vendedores com faixas de comissão A ou B

SELECT nome, faixa_comissao
FROM vendedores
WHERE faixa_comissao IN("A", "B");

-- Listar todos os clientes SEM Inscrição Estadual (IE)

SELECT * FROM clientes
WHERE ie IS NULL;

-- Listar todos os clientes COM Inscrição Estadual (IE)

SELECT * FROM clientes
WHERE ie IS NOT NULL;

-- Listar apenas os dois primeiros vendedores

SELECT * FROM vendedores
LIMIT 2;

-- Listar todos os produtos que tenham o seu nome começando por Q:

SELECT * FROM produtos
WHERE descricao LIKE "Q%";

-- Listar os vendedores que não começam por ‘Jo’:

SELECT * FROM vendedores
WHERE nome NOT LIKE "Jo%";

-- Listar todos os produtos cujo nome termina com 'o';

SELECT * FROM produtos
WHERE descricao LIKE "%o";

-- Listar os produtos que contenham as letras "inh"

SELECT * FROM produtos
WHERE descricao LIKE "%inh%";

-- Listar os chocolates e valores 

SELECT descricao, valor_unitario
FROM produtos
WHERE descricao LIKE "Chocolate";

-- Listar os vendedores cuja segunda letra do nome seja 'a'

SELECT * FROM vendedores
WHERE nome LIKE "_A%";

-- ORDER BY

-- Listar todos os vendedores ordenados por nome

SELECT * FROM vendedores
ORDER BY nome;

/* ORDER BY nome ASC; */

-- Listar todos os vendedores ordenados por nome de forma decrescente

SELECT * FROM vendedores
ORDER BY nome DESC;

-- Listar todos os vendedores ordenados por nome e salario 

SELECT * FROM vendedores
ORDER BY nome, salario;

-- Listar todos os clientes com seus estados, sendo que o estado deverá ser ordenado em ordem crescente e o nome por ordem descrescente

SELECT uf, nome
FROM clientes
ORDER BY uf ASC, nome DESC;

-- Listar todos os vendedores que ganham MENOS de 1000 reais e apresentar em ordem crescente

SELECT * FROM vendedores
WHERE salario < 1000
ORDER BY salario ASC;

-- Listar os vendedores que não começam por ‘Jo’ e apresentar ordenado de forma decrescente

SELECT nome
FROM vendedores
WHERE nome NOT LIKE "Jo%"
ORDER BY nome DESC; 

-- FUNÇÕES COUNT(), AVG(), SUM(), MIN() e MAX()

-- Informe quantos clientes foram cadastrados

SELECT COUNT(*)
FROM clientes;

-- Informe quantos produtos tem valor unitário abaixo de 0.50 centavos

SELECT COUNT(*)
FROM produtos
WHERE valor_unitario < 0.5;

-- Informe a média de salario dos vendedores

SELECT AVG(salario)
FROM vendedores;

-- Informe a média de valores unitários dos produtos vendidos a M

SELECT AVG(valor_unitario)
FROM produtos
WHERE unidade = 'M';

-- Somar o valor de todos os salários

SELECT SUM(salario)
FROM vendedores;

-- Somar o valor dos salários da comissão A

SELECT SUM(salario)
FROM vendedores
WHERE faixa_comissao = 'A';

-- Somar a quantidade de itens de pedidos

SELECT SUM(quantidade)
FROM itens_pedido;

-- Informe o menor salario do vendedores

SELECT MIN(salario)
FROM vendedores;

-- Informe o maior salario do vendedores

SELECT MAX(salario)
FROM vendedores;

-- Informe o maior salario do vendedores da faixa de comissão B

SELECT MAX(salario)
FROM vendedores
WHERE faixa_comissao = 'B';

-- Listar os nomes entre Ana e Jorge, ordenado de forma decrescente

SELECT nome 
FROM clientes
WHERE nome BETWEEN "Ana" AND "Jorge"
ORDER BY nome DESC;

-- GROUP BY

-- Informe o número de clientes por Estado

SELECT COUNT(*), uf
FROM clientes
GROUP BY uf;

-- Informe a média salarial por faixa de comissão

SELECT AVG(salario), faixa_comissao
FROM vendedores
GROUP BY faixa_comissao;

-- Informe a média salarial por faixa de comissão ordenado de forma decrescente por valor

SELECT AVG(salario), faixa_comissao
FROM vendedores
GROUP BY faixa_comissao
ORDER BY COUNT(salario) DESC;

-- HAVING

-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000 

SELECT AVG(salario) AS media, faixa_comissao
FROM vendedores
GROUP BY faixa_comissao
HAVING media > 2000;

-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000 ordenado de forma decrescente por valor

SELECT AVG(salario) AS media, faixa_comissao
FROM vendedores
GROUP BY faixa_comissao
HAVING media > 2000
ORDER BY media DESC;

-- COLUNAS CALCULADAS

-- Calcular o novo salário fixo dos vendedores, de faixa de comissão ‘A’, calculado com base no reajuste de 75% acrescido de R$ 120,00 de bonificação. Ordenar pelo nome do vendedor

SELECT nome, salario AS salario_anterior, salario * 1.75 + 120 AS novo_salario, faixa_comissao
FROM vendedores
WHERE faixa_comissao = 'C';

-- JOIN
-- Listar todos os pedidos realizados, exibindo o nome dos clientes

SELECT p.id as id_pedido, c.nome
FROM pedidos as p
INNER JOIN clientes as c
ON c.id = p.id_cliente
WHERE p.id > 100 AND nome LIKE 'a%'
ORDER BY p.id DESC;

SELECT c.nome as nome_cliente, COUNT(c.id) as qtdade_pedidos
FROM clientes as c
INNER JOIN pedidos as p
ON p.id_cliente = c.id
GROUP BY c.id
HAVING qtdade_pedidos = 1
ORDER BY nome_cliente;

-- Listar todos os pedidos realizados, exibindo o nome dos vendedores

SELECT p.id as id_pedido, v.nome
FROM pedidos as p
INNER JOIN vendedores as v
ON v.id = p.id_cliente
ORDER BY p.id DESC;

-- Listar todos os pedidos realizados, exibindo o nome dos vendedores e clientes, ordenados por prazo de entrega
-- Listar o id e prazo de entrega dos pedidos realizados pela cliente 'Susana', incluindo o nome do vendedor
-- Listar o prazo_entrega mínima para cada cliente, apresentando nome do 
-- Listar os clientes e vendedores com prazo de entrega entre 10 e 20 dias e ordene por prazo de entrega.
-- O nome do campo deve ser alterado para 

-- Listar cliente e média de prazo para entrega, considerando apenas os clientes com prazo acima de 10 dia 
-- Ao final, apresente somente os clientes cuja média é superior a 15 dias 

SELECT clientes.nome, AVG(pedidos.prazo_entrega)
FROM clientes
INNER JOIN pedidos
ON clientes.id = pedidos.id_cliente
WHERE pedidos.prazo_entrega > 10
GROUP BY clientes.nome
HAVING AVG(pedidos.prazo_entrega) > 15;

-- Ordene por prazo máximo


-- Listar os nomes dos produtos com quantidade somada, 
-- porém, considerando apenas os itens com quantidade inferior a 30.
--  Ao final, apresente apenas os itens cuja soma é superior a 40

SELECT produtos.descricao, SUM(itens_pedido.quantidade)
FROM produtos
INNER JOIN itens_pedido
ON produtos.id = itens_pedido.id_produto
WHERE itens_pedido.quantidade < 30
GROUP BY produtos.descricao
HAVING SUM(itens_pedido.quantidade) > 40;

