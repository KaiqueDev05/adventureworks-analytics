
-- ============================================================
-- PROJETO: AdventureWorks Analytics
-- BANCO: AdventureWorks2017
-- AUTOR: Kaique Elesbão
-- DATA: 2026
-- DESCRIÇÃO: Consultas SQL organizadas por categoria para
--            análise de negócio da base AdventureWorks.
-- ============================================================
--
-- GUIA DE LEITURA:
--   ✅ CONSULTA PRINCIPAL → use agora, só com o que você já sabe
--   ⭐ CONSULTA BÔNUS     → funções novas, opcionais por enquanto
--
-- ============================================================


-- ============================================================
-- SEÇÃO 1 — PRODUTOS
-- Tabela principal: Production.Product
-- Colunas úteis:
--   Name             → nome do produto
--   ListPrice        → preço de tabela
--   Color            → cor
--   Size             → tamanho
--   SafetyStockLevel → estoque mínimo de segurança
--   ReorderPoint     → ponto de reabastecimento
--   DiscontinuedDate → data de descontinuação (NULL = ativo)
-- ============================================================


-- ✅ P1: Quais são os 10 produtos com maior preço de tabela?
-- TOP 10 limita o resultado aos mais relevantes.
-- ORDER BY DESC coloca o maior valor primeiro.
-- WHERE ListPrice > 0 exclui produtos sem preço definido.

	SELECT TOP 10 ProductID, Name, ListPrice, Color
	FROM Production.Product
	WHERE ListPrice > 0
	ORDER BY ListPrice desc


-- ✅ P2: Quais cores aparecem com mais frequência no catálogo?
-- COUNT(*) conta quantos produtos existem em cada cor.
-- GROUP BY agrupa os produtos pela coluna Color.
-- HAVING Color IS NOT NULL exclui produtos sem cor cadastrada.

	SELECT color, COUNT(*) AS Resultado
	FROM Production.Product
	WHERE Color IS NOT NULL
	GROUP BY Color 
	ORDER BY Resultado desc


-- ✅ P3: Quais tamanhos aparecem mais vezes no catálogo?
-- Mesma lógica do P2, mas agrupando por tamanho.

	SELECT Size, COUNT(*) AS Resultado
	FROM Production.Product
	GROUP BY Size 
	HAVING Size IS NOT NULL
	ORDER BY Resultado desc


-- ✅ P4: Quantos produtos existem por cor?
-- Parecida com P2, mas usamos WHERE antes do GROUP BY
-- para deixar a lógica dentro do que você já estudou.
-- A diferença: aqui não mostramos produtos sem cor.

	SELECT Color, COUNT(*) AS Quantidade
	FROM Production.Product
	WHERE Color IS NOT NULL
	GROUP BY Color
	ORDER BY Quantidade desc
	


-- ✅ P5: Quais produtos possuem estoque abaixo do ponto de reabastecimento?
-- ReorderPoint = quantidade mínima antes de pedir mais estoque.
-- SafetyStockLevel = estoque de segurança definido pelo negócio.
-- Quando ReorderPoint < SafetyStockLevel, o produto está em risco.

	SELECT ProductID, Name, SafetyStockLevel, ReorderPoint
	FROM Production.Product
	WHERE ReorderPoint < SafetyStockLevel
	ORDER BY ProductID asc

-- ✅ P6: Quais produtos foram descontinuados?
-- DiscontinuedDate preenchida = produto fora de linha.
-- IS NOT NULL filtra apenas os que têm data de descontinuação.

	SELECT ProductID, Name, ListPrice ,DiscontinuedDate
	FROM Production.Product
	WHERE DiscontinuedDate IS NOT NULL
	ORDER BY ProductID

-- ============================================================
-- SEÇÃO 2 — VENDAS
-- Tabelas principais:
--   Sales.SalesOrderHeader → um registro por pedido (cabeçalho)
--   Sales.SalesOrderDetail → um registro por item do pedido
-- ============================================================


-- ✅ V1: Quais produtos tiveram o maior volume de vendas?
-- SUM(OrderQty) soma todas as quantidades vendidas por produto.
-- GROUP BY ProductID agrupa os resultados por produto.

SELECT ProductID, SUM(OrderQty) AS Resultado
	FROM sales.SalesOrderDetail
	GROUP BY ProductID
	ORDER BY Resultado desc


-- ✅ V2: Quantos pedidos foram realizados no total?
-- COUNT(*) conta todas as linhas — cada linha é um pedido.

	SELECT COUNT(*) AS TotalPedidos
	FROM sales.SalesOrderHeader


-- ✅ V3: Qual a quantidade média vendida por produto?
-- AVG calcula a média de OrderQty agrupado por produto.
-- COUNT(*) mostra em quantos pedidos o produto apareceu.

	SELECT ProductID, AVG(OrderQty) AS Media, COUNT(*) AS VezesVendido
	FROM Sales.SalesOrderDetail
	GROUP BY ProductID
	ORDER BY Media desc


-- ✅ V4: Quais produtos aparecem com mais frequência nos pedidos?
-- COUNT(*) conta em quantas linhas de pedido o produto aparece.
-- Diferente de V1 (que soma quantidade), aqui contamos frequência.

	SELECT ProductID, COUNT(*) AS FrequenciaEmProdutos
	FROM Sales.SalesOrderDetail
	GROUP BY ProductID
	ORDER BY FrequenciaEmProdutos desc

-- ============================================================
-- SEÇÃO 3 — CLIENTES
-- Tabela principal: Sales.Customer
-- Sales.SalesOrderHeader também contém CustomerID
-- ============================================================


-- ✅ C1: Quantos clientes estão cadastrados no sistema?

	SELECT COUNT(*) AS Quantidade
	FROM sales.Customer

-- ✅ C2: Qual cliente realizou o maior número de pedidos?
-- TOP 1 retorna apenas o primeiro resultado — o maior.

	SELECT TOP 1 CustomerID, COUNT(*) AS MaxPedidos
	FROM sales.SalesOrderHeader
	GROUP BY CustomerID
	ORDER BY MaxPedidos desc

-- ✅ C3: Quais são os 10 clientes com mais pedidos?
-- Igual ao C2, mas retornando os 10 primeiros para comparação.

	SELECT TOP 10 CustomerID, COUNT(*) AS MaxPedidos
	FROM sales.SalesOrderHeader
	GROUP BY CustomerID
	ORDER BY MaxPedidos desc

-- ============================================================
-- SEÇÃO 4 — ANÁLISE GERAL
-- Tabela principal: Production.Product
-- ============================================================


-- ✅ A1: Qual o preço médio dos produtos ativos?
-- AVG calcula a média de ListPrice.
-- Dois filtros combinados com AND:
--   ListPrice > 0          → exclui produtos sem preço
--   DiscontinuedDate IS NULL → exclui produtos descontinuados

SELECT AVG(ListPrice) AS Media
	FROM Production.Product
	WHERE DiscontinuedDate IS NULL AND ListPrice > 0

-- ✅ A2: Qual o produto mais caro?
-- Versão 1: retorna só o valor máximo.

	SELECT TOP 1 ListPrice AS MaisCaro
	FROM Production.Product
	ORDER BY ListPrice desc
--OU

	SELECT MAX(ListPrice) AS MaiorPreco
	FROM Production.Product

-- Versão 2: retorna o nome e o preço do produto mais caro.
-- TOP 1 + ORDER BY DESC é uma alternativa ao MAX quando
-- queremos ver mais colunas além do valor extremo.

	SELECT  TOP 1 Name, ListPrice
	FROM Production.Product
	ORDER BY ListPrice desc


-- ✅ A3: Qual o produto mais barato (com preço definido)?
-- Versão 1: retorna só o menor valor.

	SELECT TOP 1 ListPrice
	FROM Production.Product
	WHERE ListPrice IS NOT NULL AND ListPrice <> 0
	ORDER BY ListPrice asc

-- Versão 2: retorna o nome e o preço do produto mais barato.

	SELECT TOP 1 Name, ListPrice
	FROM Production.Product
	WHERE ListPrice > 0
	ORDER BY ListPrice asc

-- ✅ A4: Quantos produtos existem no total?

	SELECT COUNT(ProductID) AS Quantidade
	FROM Production.Product

-- ============================================================
-- SEÇÃO 5 — CONSULTA BÔNU
-- ============================================================

-- ⭐ BÔNUS 1: Receita bruta por produto
-- LineTotal é uma coluna já calculada em SalesOrderDetail
-- (UnitPrice × OrderQty com desconto aplicado).
-- Tudo aqui usa funções que você já conhece (SUM, COUNT, GROUP BY).

	SELECT TOP 10 ProductID,
		SUM(LineTotal) AS ReceitaBruta,
		COUNT(*) AS NumeroDePedidos,
		SUM(OrderQty) AS QuantidadeTotal
	FROM Sales.SalesOrderDetail
	GROUP BY ProductID
	ORDER BY ReceitaBruta desc
