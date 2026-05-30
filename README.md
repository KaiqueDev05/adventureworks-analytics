# 🚲 AdventureWorks Analytics — SQL Project

> Análise de negócio completa sobre o banco de dados AdventureWorks2017 (Microsoft),
> utilizando SQL Server. O projeto cobre produtos, vendas, clientes e análise geral
> com consultas organizadas por categoria e nível de complexidade.

---

## 📌 Sobre o Projeto

Este projeto foi desenvolvido como parte do meu aprendizado em SQL, com o objetivo de
praticar consultas reais em um banco de dados de negócio. O AdventureWorks é um banco
público da Microsoft que simula uma empresa de fabricação e venda de bicicletas.

**Banco de dados:** AdventureWorks2017  
**Tecnologia:** SQL Server (T-SQL)  
**Autor:** Kaique Elesbão  
**Ano:** 2026

---

## 🗂️ Estrutura do Projeto

```
adventureworks-analytics/
│
├── consultas.sql        ← todas as queries organizadas por seção
└── README.md            ← documentação do projeto
```

---

## 📋 Seções e Consultas

### Seção 1 — Produtos (`Production.Product`)

| ID | Pergunta de Negócio |
|----|---------------------|
| P1 | Quais são os 10 produtos com maior preço de tabela? |
| P2 | Quais cores aparecem com mais frequência no catálogo? |
| P3 | Quais tamanhos aparecem mais vezes no catálogo? |
| P4 | Quantos produtos existem por cor? |
| P5 | Quais produtos possuem estoque abaixo do ponto de reabastecimento? |
| P6 | Quais produtos foram descontinuados? |

### Seção 2 — Vendas (`Sales.SalesOrderHeader` / `Sales.SalesOrderDetail`)

| ID | Pergunta de Negócio |
|----|---------------------|
| V1 | Quais produtos tiveram o maior volume de vendas? |
| V2 | Quantos pedidos foram realizados no total? |
| V3 | Qual a quantidade média vendida por produto? |
| V4 | Quais produtos aparecem com mais frequência nos pedidos? |

### Seção 3 — Clientes (`Sales.Customer`)

| ID | Pergunta de Negócio |
|----|---------------------|
| C1 | Quantos clientes estão cadastrados no sistema? |
| C2 | Qual cliente realizou o maior número de pedidos? |
| C3 | Quais são os 10 clientes com mais pedidos? |

### Seção 4 — Análise Geral

| ID | Pergunta de Negócio |
|----|---------------------|
| A1 | Qual o preço médio dos produtos ativos? |
| A2 | Qual o produto mais caro? |
| A3 | Qual o produto mais barato (com preço definido)? |
| A4 | Quantos produtos existem no total? |

### Seção 5 — Bônus

| ID | Pergunta de Negócio |
|----|---------------------|
| B1 | Qual a receita bruta por produto? |

---

## 💡 Principais Insights

### Produtos
- O produto mais caro é o **Road-150 Red** com preço de tabela de **$3.578,27**
- O produto mais barato com preço definido é o **Patch Kit/8 Patches** a **$2,29**
- O preço médio dos produtos ativos é de aproximadamente **$727,26**
- O catálogo conta com **504 produtos** no total
- A cor mais comum é **Black** (93 produtos), seguida de Silver (43) e Red (38)
- O tamanho mais frequente é **44 e 48** (com 29 e 25 produtos respectivamente cada)
- A coluna `DiscontinuedDate` não possui registros preenchidos no AdventureWorks 2017 — resultado esperado de 0 linhas

### Vendas
- Total de **31.465 pedidos** registrados no sistema
- O produto com maior volume vendido (quantidade total) é o **ProductID 712** — AWC Logo Cap
- O produto que aparece com mais frequência nos pedidos é o **ProductID 870** — Water Bottle,  
  mostrando que frequência em pedidos e volume total são métricas distintas
- Produtos com alta média de venda e poucos pedidos indicam compras em grande lote

### Clientes
- O sistema possui **+19.000 clientes** cadastrados
- O cliente mais ativo realizou **28 pedidos**
- Os 10 clientes mais ativos estão na faixa de **26 a 28 pedidos**

---

## 🧠 Conceitos SQL Utilizados

| Conceito | Onde foi usado |
|----------|----------------|
| `SELECT`, `FROM`, `WHERE` | Todas as seções |
| `ORDER BY ASC / DESC` | Todas as seções |
| `TOP N` | P1, C2, C3, A2, A3, B1 |
| `COUNT(*)` | P2, P3, P4, V2, V4, C1, C2, C3 |
| `SUM()` | V1, B1 |
| `AVG()` | V3, A1 |
| `GROUP BY` | P2, P3, P4, V1, V3, V4, C2, C3 |
| `HAVING` | P3 |
| `IS NULL / IS NOT NULL` | P5, P6, A1 |
| `AND` (múltiplos filtros) | A1 |

---

## 🔜 Próximos Passos — Parte II (com JOIN)

As consultas abaixo serão implementadas na continuação do projeto, após o estudo de `JOIN`:

- Nome do produto no ranking de vendas *(JOIN entre SalesOrderDetail e Product)*
- Nome do cliente no ranking de pedidos *(JOIN entre SalesOrderHeader e Customer + Person)*
- Receita total por categoria de produto *(JOIN entre Product, ProductSubcategory e ProductCategory)*
- Produtos que nunca foram vendidos *(LEFT JOIN entre Product e SalesOrderDetail)*
- Ticket médio por pedido *(JOIN entre SalesOrderHeader e SalesOrderDetail)*

---

## ▶️ Como Executar

1. Faça o download do banco AdventureWorks2017 em:  
   https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks

2. Restaure o banco no SQL Server Management Studio (SSMS)

3. Abra o arquivo `consultas.sql` no SSMS e execute as queries por seção

---

## 📬 Contato

**Kaique Elesbão**  
[LinkedIn](https://www.linkedin.com/in/kaique-elesb%C3%A3o-87a774259/) · [GitHub](https://github.com/Kaiquedev05)
