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
	idPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
    preco DOUBLE DEFAULT 10,
    quantidade DOUBLE DEFAULT 0
);