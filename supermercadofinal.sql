DROP DATABASE SUPERMERCADO;
CREATE DATABASE IF NOT EXISTS SUPERMERCADO;
USE SUPERMERCADO;

-- TABELA CLIENTE
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(100),
    cpf VARCHAR(14) UNIQUE,
    data_nascimento DATE,
    data_cadastro DATE,
    email VARCHAR(100)
);

-- TABELA COLABORADOR
CREATE TABLE colaborador (
    id_colaborador INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(100),
    cpf VARCHAR(14) UNIQUE,
    data_nascimento DATE,
    data_contratacao DATE,
    cargo VARCHAR(50),
    funcao VARCHAR(50),
    salario DECIMAL(10,2),
    status BOOLEAN -- TRUE = ativo, FALSE = inativo
);

-- TABELA ENDERECO
CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(100),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    cep VARCHAR(10)
);

-- TABELA CLIENTE_ENDERECO
CREATE TABLE cliente_endereco (
    id_cliente INT,
    id_endereco INT,
    PRIMARY KEY (id_cliente, id_endereco),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco) ON DELETE CASCADE
);

-- TABELA TELEFONE
CREATE TABLE telefone (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(20),
    tipo_telefone VARCHAR(20) -- Ex: 'residencial', 'comercial', 'celular'
);

-- TABELA COLABORADOR_ENDERECO
CREATE TABLE colaborador_endereco (
    id_colaborador INT,
    id_endereco INT,
    PRIMARY KEY (id_colaborador, id_endereco),
    FOREIGN KEY (id_colaborador) REFERENCES colaborador(id_colaborador) ON DELETE CASCADE,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco) ON DELETE CASCADE
);

-- TABELA CLIENTE_TELEFONE
CREATE TABLE cliente_telefone (
    id_cliente INT,
    id_telefone INT,
    PRIMARY KEY (id_cliente, id_telefone),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_telefone) REFERENCES telefone(id_telefone) ON DELETE CASCADE
);

-- TABELA COLABORADOR_TELEFONE
CREATE TABLE colaborador_telefone (
    id_colaborador INT,
    id_telefone INT,
    PRIMARY KEY (id_colaborador, id_telefone),
    FOREIGN KEY (id_colaborador) REFERENCES colaborador(id_colaborador) ON DELETE CASCADE,
    FOREIGN KEY (id_telefone) REFERENCES telefone(id_telefone) ON DELETE CASCADE
);

-- TABELA PRODUTO
CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    fabricante VARCHAR(100),
    nome VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10,2),
    quantidade_disponivel INT,
    categoria VARCHAR(50),
    validade DATE,
    codigo_produto VARCHAR(30) UNIQUE,
    localizacao VARCHAR(50)
);

-- TABELA VENDA
CREATE TABLE venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_colaborador INT,
    data_venda DATETIME,
    forma_pagamento VARCHAR(30),
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_colaborador) REFERENCES colaborador(id_colaborador)
);

-- TABELA ITEM_VENDA
CREATE TABLE item_venda (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

INSERT INTO cliente (nome_completo, cpf, data_nascimento, data_cadastro, email) VALUES
('Ana Beatriz da Silva', '123.456.789-01', '1990-05-12', '2023-01-10', 'ana.silva@gmail.com'),
('João Pedro Alves', '234.567.890-12', '1985-08-30', '2022-11-02', 'joao.alves@yahoo.com'),
('Carla Menezes Rocha', '345.678.901-23', '1992-03-18', '2024-02-15', 'carla.rocha@hotmail.com'),
('Fernando Lima Sousa', '456.789.012-34', '1988-10-05', '2021-07-22', 'fernando.sousa@gmail.com'),
('Patrícia Gomes Martins', '567.890.123-45', '1995-12-22', '2023-09-18', 'patricia.martins@outlook.com');


INSERT INTO colaborador (nome_completo, cpf, data_nascimento, data_contratacao, cargo, funcao, salario, status) VALUES
('Marcos Antônio Ribeiro', '321.654.987-00', '1980-01-10', '2020-03-01', 'Gerente', 'Gestor de Vendas', 6500.00, TRUE),
('Luciana Oliveira Costa', '432.765.098-11', '1991-07-21', '2021-06-15', 'Atendente', 'Suporte ao Cliente', 2800.00, TRUE),
('Bruno Henrique Santos', '543.876.109-22', '1993-11-14', '2022-08-10', 'Estoquista', 'Controle de Estoque', 2500.00, TRUE),
('Juliana Souza Freitas', '654.987.210-33', '1987-04-03', '2019-09-01', 'Vendedor', 'Vendas', 3000.00, FALSE),
('Daniel Almeida Nunes', '765.098.321-44', '1985-09-25', '2023-01-05', 'TI', 'Suporte Técnico', 3500.00, TRUE);

INSERT INTO endereco (logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
('Rua das Palmeiras', '123', 'Apto 101', 'Jardim Paulista', 'São Paulo', 'SP', '01423-001'),
('Av. Brasil', '456', '', 'Centro', 'Rio de Janeiro', 'RJ', '20040-001'),
('Rua Afonso Pena', '789', 'Casa', 'Boa Vista', 'Belo Horizonte', 'MG', '30130-003'),
('Travessa da Luz', '12', '', 'Liberdade', 'Salvador', 'BA', '40045-120'),
('Rua Dom Pedro II', '55', 'Fundos', 'Centro', 'Curitiba', 'PR', '80010-000');

INSERT INTO telefone (numero, tipo_telefone) VALUES
('(11) 91234-5678', 'celular'),
('(21) 99876-5432', 'celular'),
('(31) 3344-5566', 'residencial'),
('(71) 98877-6655', 'comercial'),
('(41) 98765-4321', 'celular');

INSERT INTO cliente_endereco (id_cliente, id_endereco) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO cliente_telefone (id_cliente, id_telefone) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO colaborador_endereco (id_colaborador, id_endereco) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO colaborador_telefone (id_colaborador, id_telefone) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO produto (fabricante, nome, descricao, preco, quantidade_disponivel, categoria, validade, codigo_produto, localizacao) VALUES
('Samsung', 'Smartphone Galaxy A14', 'Smartphone com 128GB de armazenamento', 1299.90, 50, 'Eletrônicos', '2026-12-01', 'SAM-A14-128GB', 'Estoque A1'),
('LG', 'Smart TV 50"', 'Smart TV 4K com controle por voz', 2299.99, 20, 'Eletrônicos', '2027-06-15', 'LG-TV50-4K', 'Estoque B3'),
('Apple', 'iPhone 13', 'Smartphone Apple com 128GB', 4499.00, 15, 'Eletrônicos', '2026-09-01', 'APL-IP13-128GB', 'Estoque A2'),
('Dell', 'Notebook Inspiron 15', 'Notebook com i5 e 8GB RAM', 3599.00, 30, 'Informática', '2027-03-01', 'DEL-INS15', 'Estoque C1'),
('Logitech', 'Mouse sem fio M170', 'Mouse sem fio com pilha AA', 99.90, 100, 'Acessórios', '2028-01-01', 'LOG-M170', 'Estoque D2');

INSERT INTO venda (id_cliente, id_colaborador, data_venda, forma_pagamento, valor_total) VALUES
(1, 1, '2025-04-01 10:15:00', 'cartão crédito', 1399.80),
(2, 2, '2025-04-05 15:45:00', 'boleto', 4598.90),
(3, 3, '2025-04-07 12:30:00', 'cartão débito', 2399.89),
(4, 4, '2025-04-12 16:00:00', 'pix', 3698.90),
(5, 5, '2025-04-20 09:50:00', 'dinheiro', 99.90);

INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 1299.90),
(1, 5, 1, 99.90),

(2, 3, 1, 4499.00),
(2, 5, 1, 99.90),

(3, 2, 1, 2299.99),
(3, 5, 1, 99.90),

(4, 4, 1, 3599.00),
(4, 5, 1, 99.90),

(5, 5, 1, 99.90);


CREATE VIEW view_detalhes_vendas AS
SELECT
    v.id_venda,
    c.nome_completo AS cliente,
    col.nome_completo AS colaborador,
    v.data_venda,
    v.forma_pagamento,
    p.nome AS produto,
    iv.quantidade,
    iv.preco_unitario,
    (iv.quantidade * iv.preco_unitario) AS total_item
FROM venda v
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN colaborador col ON v.id_colaborador = col.id_colaborador
JOIN item_venda iv ON v.id_venda = iv.id_venda
JOIN produto p ON iv.id_produto = p.id_produto;

CREATE VIEW view_total_por_cliente AS
SELECT
    c.id_cliente,
    c.nome_completo,
    SUM(v.valor_total) AS total_gasto
FROM cliente c
JOIN venda v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome_completo;


CREATE VIEW view_produtos_mais_vendidos AS
SELECT
    p.id_produto,
    p.nome,
    SUM(iv.quantidade) AS total_vendido
FROM produto p
JOIN item_venda iv ON p.id_produto = iv.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY total_vendido DESC;

CREATE VIEW view_colaboradores_ativos AS
SELECT
    id_colaborador,
    nome_completo,
    cargo,
    funcao,
    salario
FROM colaborador
WHERE status = TRUE;

CREATE VIEW view_estoque_atual AS
SELECT
    id_produto,
    nome,
    quantidade_disponivel,
    preco,
    localizacao
FROM produto;

CREATE VIEW view_clientes_contato AS
SELECT
    c.id_cliente,
    c.nome_completo,
    c.email,
    e.logradouro,
    e.numero,
    e.complemento,
    e.bairro,
    e.cidade,
    e.estado,
    e.cep,
    t.numero AS telefone,
    t.tipo_telefone
FROM cliente c
LEFT JOIN cliente_endereco ce ON c.id_cliente = ce.id_cliente
LEFT JOIN endereco e ON ce.id_endereco = e.id_endereco
LEFT JOIN cliente_telefone ct ON c.id_cliente = ct.id_cliente
LEFT JOIN telefone t ON ct.id_telefone = t.id_telefone;

CREATE VIEW view_colaboradores_contato AS
SELECT
    col.id_colaborador,
    col.nome_completo,
    col.cargo,
    col.funcao,
    col.salario,
    col.status,
    e.logradouro,
    e.numero,
    e.complemento,
    e.bairro,
    e.cidade,
    e.estado,
    e.cep,
    t.numero AS telefone,
    t.tipo_telefone
FROM colaborador col
LEFT JOIN colaborador_endereco ce ON col.id_colaborador = ce.id_colaborador
LEFT JOIN endereco e ON ce.id_endereco = e.id_endereco
LEFT JOIN colaborador_telefone ct ON col.id_colaborador = ct.id_colaborador
LEFT JOIN telefone t ON ct.id_telefone = t.id_telefone;

SELECT * FROM view_clientes_contato;

SELECT * FROM view_colaboradores_contato;

SELECT * FROM view_total_por_cliente;

SELECT * FROM view_produtos_mais_vendidos;

SELECT * FROM view_colaboradores_ativos;

SELECT * FROM view_estoque_atual;

select * from produto;

