
/*Inserindo os usuários */
INSERT INTO Usuario (Login, Senha) VALUES
('op1', 'op1'),
('op2', 'op2');

/*Inserindo os Produtos */
INSERT INTO Produto (nome, quantidade, precoVenda) VALUES
('Banana', '100', '5.01'),
('Laranja', '500', '2.02'),
('Manga', '800', '4.03'),
('Pera tomy', '40', '300');

/*Inserindo as Pessoas */
INSERT INTO Pessoa ( nome, logradouro, cidade, estado, telefone, email) VALUES 
( 'João', 'Rua 17', 'Albuquerque', 'PA', '9999999998', 'email@joao.com'),
 ( 'Jose', 'Rua 7', 'Albuquerque', 'PA', '9999999999', 'email@jose.com'), 
 ( 'Ruan', 'rua das couves', 'londres', 'rj', '1212112', 'hhiahsias');

 /*Inserindo as Pessoas Fisicas */
INSERT INTO PessoaFisica (idPessoa, nome, logradouro, cidade, estado, telefone, email, cpf) VALUES
( 10,'Jose', 'Rua 7', 'Albuquerque', 'PA', '9999999999', 'email@jose.com', '12345678900'),
( 5,'Jose', 'Rua 7', 'Albuquerque', 'PA', '9999999999', 'email@jose.com', '1212121212');

/*Inserindo as Pessoas Juridicas */
INSERT INTO PessoaJuridica (idPessoa, nome, logradouro, cidade, estado, telefone, email, cnpj) VALUES
( 13,'João', 'Rua 17', 'Albuquerque', 'PA', '9999999998', 'email@joao.com', '1212121213');

/*Inserindo as Movimentações */
INSERT INTO Movimentacao (idUsuario, idPessoa, idProduto, quantidade, tipo, valor_unitario) VALUES
(1, 5, 1, '10', 'S', '4.00'),
(1, 10, 2, '100', 'E', '41.10'),
(2, 5, 3, '56', 'S', '200.01'),
(2, 13, 4, '12', 'E', '11.11');

/*Dados completos de pessoas físicas. */
SELECT * FROM PessoaFisica;

/*Dados completos de pessoas jurídicas. */
SELECT * FROM PessoaJuridica;

/*Movimentações de entrada, com produto, fornecedor, quantidade,preço unitário e valor total.*/
SELECT 
	Movimentacao.tipo, 
	Pessoa.nome AS Fornecedor, 
	Produto.nome,
	Movimentacao.quantidade,
	Produto.precoVenda AS Preco_Unitario,
	(Movimentacao.quantidade * Produto.precoVenda) AS ValorTotal
FROM
	Movimentacao
JOIN 
	Pessoa ON Movimentacao.idPessoa = Pessoa.idPessoa
JOIN
	Produto ON Movimentacao.idProduto = Produto.idProduto
WHERE
	Movimentacao.tipo = 'E';

/*Movimentações de saída, com produto, comprador, quantidade, preço unitário e valor total. */
SELECT 
	Movimentacao.tipo, 
	Pessoa.nome AS Comprador, 
	Produto.nome,
	Movimentacao.quantidade,
	Produto.precoVenda AS Preco_Unitario,
	(Movimentacao.quantidade * Produto.precoVenda) AS ValorTotal
FROM
	Movimentacao
JOIN 
	Pessoa ON Movimentacao.idPessoa = Pessoa.idPessoa
JOIN
	Produto ON Movimentacao.idProduto = Produto.idProduto
WHERE
	Movimentacao.tipo = 'S';

/*Valor total das entradas agrupadas por produto. */
SELECT
	Produto.nome AS Produto,
	SUM(Movimentacao.quantidade * Produto.precoVenda) AS ValorTotalEntradas
FROM
	Movimentacao
JOIN
	Produto ON Movimentacao.idProduto = Produto.idProduto
WHERE
	Movimentacao.tipo = 'E'
GROUP BY
	Produto.nome;

/*Valor total das saídas agrupadas por produto. */
SELECT
	Produto.nome AS Produto,
	SUM(Movimentacao.quantidade * Produto.precoVenda) AS ValorTotalSaidas
FROM
	Movimentacao
JOIN
	Produto ON Movimentacao.idProduto = Produto.idProduto
WHERE
	Movimentacao.tipo = 'S'
GROUP BY
	Produto.nome;

/*Operadores que não efetuaram movimentações de entrada (compra). */
SELECT
    Pessoa.nome AS OperadorSemEntrada
FROM
    Pessoa
WHERE
	idPessoa NOT IN (
		SELECT DISTINCT Movimentacao.idPessoa
		FROM Movimentacao
		WHERE Movimentacao.tipo = 'E'

	);

/*Valor total de entrada, agrupado por operador. */
SELECT
    Pessoa.nome AS Operador,
    SUM(Movimentacao.quantidade * Produto.precoVenda) AS ValorTotalEntrada
FROM
    Pessoa
LEFT JOIN
    Movimentacao ON Pessoa.idPessoa = Movimentacao.idPessoa
LEFT JOIN
    Produto ON Movimentacao.idProduto = Produto.idProduto
WHERE
    Movimentacao.tipo = 'E'
GROUP BY
    Pessoa.nome;

/*Valor total de saída, agrupado por operador. */
SELECT
    Pessoa.nome AS Operador,
    SUM(Movimentacao.quantidade * Produto.precoVenda) AS ValorTotalSaida
FROM
    Pessoa
LEFT JOIN
    Movimentacao ON Pessoa.idPessoa = Movimentacao.idPessoa
LEFT JOIN
    Produto ON Movimentacao.idProduto = Produto.idProduto
WHERE
    Movimentacao.tipo = 'S'
GROUP BY
    Pessoa.nome;

/*Valor médio de venda por produto, utilizando média ponderada. */
SELECT
    Produto.nome AS Produto,
    SUM(Movimentacao.quantidade * Movimentacao.valor_unitario) / SUM(Movimentacao.quantidade) AS ValorMedioVenda
FROM
    Produto
LEFT JOIN
    Movimentacao ON Produto.idProduto = Movimentacao.idProduto
WHERE
    Movimentacao.tipo = 'S'
GROUP BY
    Produto.nome;



