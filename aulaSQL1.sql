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

select nome, preco
from produto
where nome like '%A%' AND preco > 5.00;


