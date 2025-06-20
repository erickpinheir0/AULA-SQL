select * from cidade;

SHOW DATABASES;

USE loja;

CREATE TABLE pessoa(
	idPessoa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    altura DOUBLE DEFAULT 1.76,
    nascimento DATE DEFAULT '1989-12-19',
    endereco TEXT,
	codCidade  INT,
    FOREIGN KEY (codCidade) REFERENCES cidade (idCidade)
);

ALTER TABLE pessoa
ADD COLUMN telefone VARCHAR(20) NOT NULL;

ALTER TABLE pessoa
CHANGE telefone
fone VARCHAR(20);

ALTER TABLE pessoa DROP fone; 

CREATE TABLE pedido(
	idPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    horario DATETIME DEFAULT NOW(), 
    endereco TEXT ,
    codCliente INT NOT NULL,
    FOREIGN KEY (codCliente) REFERENCES pessoa (idPessoa)
);

CREATE TABLE cidade (
	idCidade INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100)
);

CREATE TABLE categoria (
	idCategoria INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL
);

CREATE TABLE produto (
	idProduto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
    preco DOUBLE DEFAULT 10,
    quantidade DOUBLE DEFAULT 0
);



CREATE TABLE eletronico (
	codProduto INT NOT NULL PRIMARY KEY,
    amperagem DOUBLE, 
    voltagem DOUBLE,
    bivolt BOOLEAN,
    FOREIGN KEY (codProduto) REFERENCES produto(idProduto)
);

CREATE TABLE percivel (
	codProduto INT NOT NULL PRIMARY KEY,
    temperaturaMinima DOUBLE, 
    temperaturaMaxima DOUBLE,
    FOREIGN KEY (codProduto) REFERENCES produto(idProduto)
);

CREATE TABLE categoria_produto (
	codCategoria INT NOT NULL,
    codProduto INT NOT NULL,
    PRIMARY KEY (codCategoria, codProduto), 
    FOREIGN KEY (codCategoria) REFERENCES categoria(idCategoria),
    FOREIGN KEY (codProduto) REFERENCES produto(idProduto)
);

CREATE TABLE pedido_produto (
	codPedido INT NOT NULL,
    codProduto INT NOT NULL,
    precoVendido DOUBLE,
    quantidadeVendida DOUBLE,
    PRIMARY KEY (codPedido, codProduto), 
    FOREIGN KEY (codPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (codProduto) REFERENCES produto(idProduto)
);


DESCRIBE pessoa;

INSERT INTO cidade (idCidade, nome) VALUES (1, "Porto Alegre");
INSERT INTO cidade (nome, idCidade) VALUES ("Viamão", 2);
INSERT INTO cidade  VALUES (3, "Canoas");
INSERT INTO cidade  VALUES (NULL, "Alvorada");
INSERT INTO cidade(nome) VALUES ("Capão da Canoa");

INSERT INTO cidade(nome) VALUES
("São Paulo"),
("Florianópolis");

SELECT * FROM cidade;

INSERT INTO pessoa VALUES (NULL, "João", 1.85, "1985-05-20", "Rua A, 100", 3);

INSERT INTO pessoa(nome, altura, codCidade, nascimento, endereco) VALUES ("Zacarias", 2.01, 5, "2005-07-25", "Rua F, 500");

INSERT INTO pessoa(nome, altura, codCidade, nascimento, endereco) VALUES 
("José", 1.78, 1, "1994-02-05", "Rua C, 200"),
("Julia", 1.50, 4, "2005-10-18", "Rua D, 400");


INSERT INTO pessoa(nome) VALUES ("Renata") , ("Roberto");

SELECT * FROM pessoa;

DELETE FROM cidade WHERE ( ( idCidade = 2 )  OR ( idCidade = 5 ) ); 



INSERT INTO categoria ( nome ) VALUES 
( "Bebidas" ) ,
( "Alimentos" ) ,
( "Limpeza" ) ;

INSERT INTO produto (nome, preco, quantidade) VALUES
( "Coca-cola" , 9.89 , 100  ) ,
( "Pepsi" , 6.99 , 80  ) ,
( "Trakinas" , 3.95 , 50  ) ,
( "Arroz" , 3.99 , 100 ) ,
( "Doritos" , 11.99 , 60 ) ,
( "Fanta" , 7.99 , 180  );

INSERT INTO categoria_produto VALUES 
( 1 , 1 ) , 
( 1 , 2 ) ,
( 2 , 3 ) ,
( 2 , 4 ) ,
( 2 , 5 ) ,
( 1 , 6 );

INSERT INTO pedido ( horario , endereco , codCliente) VALUES
( "2024-10-17 18:10:30" , "Rua A, 100" , 2 );

INSERT INTO pedido ( endereco , codCliente) VALUES
( "Rua B, 200" , 1 );

INSERT INTO pedido (codCliente) VALUES ( 2 );

INSERT INTO pedido_produto VALUES 
( 1 , 1 ,  8.00 , 4 ) , 
( 1 , 5 , 11.99 , 2 ) ,
( 1 , 3 ,  3.95 , 1 ) ;

INSERT INTO pedido_produto (codPedido, codProduto, precoVendido) VALUES 
( 2 , 1 ,  9.89 ) , 
( 2 , 4 ,  3.99 ) ;

DESCRIBE pedido;
SELECT * FROM pedido_produto;

SELECT idPessoa, nome, altura, nascimento
FROM pessoa
ORDER BY altura DESC, nome DESC; 

SELECT idPessoa, nome, altura, 
	DATE_FORMAT(nascimento, '%d/%m/%Y') AS 'Data de Nascimento'
FROM pessoa; 

-- Funções de Agregação
SELECT MIN( altura ), MAX( altura ), AVG( altura ), 
		SUM( altura), COUNT( altura )
FROM pessoa;

SELECT nome, altura 
FROM pessoa
WHERE altura > ( SELECT AVG(altura) FROM pessoa );

SELECT nome, altura
FROM pessoa
WHERE nome LIKE '%o%' AND altura > 1.6;
select * from produto;


-- 1) Monte uma consulta que retorna os produtos
-- que contenham a letra A no nome e que o preço 
-- seja maior que 5, ordenando pelo nome do produto

-- 2) Monte uma consulta que retorna o nome e a 
-- data de nascimento, somente das pessoas que
-- nasceram até o dia 15

-- 3) Monte uma consulta que retorna o nome do produto
-- o valor em reais de estoque de cada produto

-- 4) Monte uma consulta que retorna qual o valor em reais
-- do estoque inteiro 

-- 1
SELECT * FROM produto
WHERE nome LIKE '%a%' AND preco > 5
ORDER BY nome;

-- 2
SELECT nome, DATE_FORMAT(nascimento, '%d/%m/%Y')  AS nascimento
FROM pessoa
WHERE DATE_FORMAT(nascimento, '%d') < 16;

-- 3
SELECT nome,  (preco * quantidade) AS estoque
FROM produto;

SELECT nome, preco, quantidade, (preco * quantidade) AS estoque, 
CONCAT( "R$ " , (preco * quantidade) ) AS valor
FROM produto
ORDER BY estoque;

-- 4
SELECT SUM( preco * quantidade ) AS estoqueTotal
FROM produto;


-- 06/06/2025 ---------

INSERT INTO cidade (nome) VALUES ("Capão da Canoa");

SELECT DISTINCT * FROM cidade ORDER BY nome;

SELECT nome, preco
FROM produto
ORDER BY preco DESC
LIMIT 2;

SELECT nome, preco
FROM produto
WHERE preco IN (9.89, 3.95, 7.99, 5.45);


SELECT pessoa.idPessoa, pessoa.nome, pessoa.codCidade, 
cidade.idCidade, cidade.nome
FROM pessoa
INNER JOIN cidade ON pessoa.codCidade = cidade.idCidade;

SELECT p.idPessoa, p.nome, p.codCidade, c.idCidade, c.nome
FROM pessoa p
INNER JOIN cidade c ON p.codCidade = c.idCidade;

SELECT pessoa.idPessoa, pessoa.nome, pessoa.codCidade, 
cidade.idCidade, cidade.nome
FROM pessoa
LEFT JOIN cidade ON pessoa.codCidade = cidade.idCidade;

SELECT pessoa.idPessoa, pessoa.nome, pessoa.codCidade, 
cidade.idCidade, cidade.nome
FROM pessoa
RIGHT JOIN cidade ON pessoa.codCidade = cidade.idCidade;

-- construa uma consulta que retorna todos os produtos, 
-- juntamente com o nome da sua categoria 
-- independetemente se o produto possui categoria 

-- monte uma consulta que retorna pessoas,
-- juntamente com o nome da sua cidade, mas só das pessoas
-- que moram em cidades que tenham a letra A no nome
-- ordenando pelo nome das pessoas


SELECT p.*, c.nome
FROM pessoa p
JOIN cidade c ON c.idCidade = p.codCidade
WHERE c.nome LIKE '%a%' 
ORDER BY p.nome;


SELECT idCidade, nome , 
	( select COUNT(idPessoa)
	  FROM pessoa
      WHERE codCidade = idCidade
    ) AS moradores
FROM cidade;

SELECT nome, preco
FROM produto
WHERE preco > ( SELECT AVG(preco) 
				FROM produto 
             --   WHERE nome LIKE 'a%'
                );


-- Monte uma consulta que retorna uma lista de categorias
-- com IdCategoria, com o nome da categoria e o total de
-- produtos que pertencem a cada categoria.
-- Independentemente se a categoria possui produtos.

SELECT c.idCategoria, c.nome,
			(SELECT COUNT(p.idProduto)
            FROM produto p
            INNER JOIN categoria_produto cp
            ON p.idProduto = cp.codProduto
            WHERE cp.codCategoria = c.idCategoria
            ) AS totalProdutos
FROM categoria c;

-- Monte uma consulta que retorna a lista de pedidos
-- com da data do pedido, o nome do cliente, independemente se o pedido
-- tem cliente e o valor total do pedido

SELECT p.idPedido, DATE_FORMAT( p.horario, '%d/%m/%Y %H:%i:%s') AS data,
	c.nome AS cliente , 
			( 
				SELECT SUM(pp.precoVendido * pp.quantidadeVendida)  
				FROM pedido_produto pp
				WHERE pp.codPedido = p.idPedido
			) AS valorPedido

FROM pedido p
LEFT JOIN pessoa c ON p.codCliente = c.idPessoa;


SELECT * FROM pedido_produto;

INSERT INTO pedido VALUES ();

DESCRIBE pedido;

ALTER TABLE pedido 
CHANGE codCliente 
codCliente INT NULL;     


-- 20-06-2025 ------------------------------------------------------------------------------------------------------------------------

SELECT p.idProduto, p.nome 
FROM produto p
WHERE EXISTS ( 
				SELECT pp.codProduto
                FROM pedido_produto pp
                WHERE pp.codProduto = p.idProduto 
						AND pp.quantidadeVendida > 0
			);
SELECT * FROM pedido_produto;            

-- Utilizando a função EXISTS, construa uma consulta que 
-- retorna as cidades que não possuem moradores
SELECT c.idCidade, c.nome 
FROM cidade c
WHERE NOT EXISTS (
					SELECT * FROM pessoa p
                    WHERE p.codCidade = c.idCidade
				);
                



-- Consulta que retorna as categorias e a quantidade de produtos 
-- que cada categoria tem	
SELECT c.nome, COUNT( cp.codProduto ) AS total
FROM categoria c
LEFT JOIN categoria_produto cp ON cp.codCategoria = c.idCategoria
GROUP BY nome;

-- Monte uma consulta que retorna os nomes das cidades e 
-- a quantidade de moradores de cada cidade, inclusive das
-- cidades que não possuem moradores
SELECT c.nome, COUNT( p.idPessoa ) AS moradores
FROM cidade c 
LEFT JOIN pessoa p ON p.codCidade = c.idCidade
GROUP BY c.nome
ORDER BY moradores DESC, nome;


-- consulta que retorna os nomes das cidades e 
-- a quantidade de moradores de cada cidade, apenas das cidades que possuem
-- mais de 1 morador
SELECT c.nome, COUNT( p.idPessoa ) AS moradores
FROM cidade c 
INNER JOIN pessoa p ON p.codCidade = c.idCidade
GROUP BY c.nome
HAVING moradores > 1
ORDER BY moradores DESC, nome;

-- Monte uma consulta que retorna os nomes das categorias e 
-- a quantidade de produtos de cada categoria, mas apenas
-- das categorias que possuem pelo menos 2 produtos
SELECT c.nome, COUNT( cp.codProduto ) AS total
FROM categoria c
INNER JOIN categoria_produto cp ON cp.codCategoria = c.idCategoria
GROUP BY nome
HAVING total > 1;

