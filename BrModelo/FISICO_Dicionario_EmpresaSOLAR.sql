-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Compra (
ID_Produto Texto(1),
ID_Cliente Texto(1)/*falha: chave estrangeira*/
)

CREATE TABLE Cliente (
ID_Cliente Texto(1) PRIMARY KEY,
Nome_Cliente Texto(1)
)

CREATE TABLE Produtos (
ID_Produto Texto(1) PRIMARY KEY,
Nome_Produto Texto(1)
)

ALTER TABLE Compra (
ID_Compra int auto_increment PRIMARY KEY NOT NULL,
ID_Produto int,
ID_Cliente INT,
ADD FOREIGN KEY(ID_Produto) REFERENCES Produtos (ID_Produto),
FOREIGN KEY(ID_Cliente) REFERENCES Clientes(ID_Cliente),
)
