-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE cliente (
id_cliente(PK) Texto(1),
nome(not null) Texto(1),
telefone(not null) Texto(1),
email(not null) Texto(1),
endereco (varchar) Texto(1),
cpf Texto(1)
)

CREATE TABLE OrdemServico (
id_os Texto(1),
data_abertura Texto(1),
data_conclusao Texto(1),
status_os Texto(1),
descricao_problema Texto(1),
diagnostico_tecnico Texto(1)
)

CREATE TABLE servico (
id_servico Texto(1),
nome Texto(1),
descricao Texto(1),
valor_mao_obra Texto(1)
)

CREATE TABLE mecanico (
id_mecanico Texto(1),
nome Texto(1),
cpf Texto(1),
especialidade Texto(1)
)

CREATE TABLE peca (
id_peca Texto(1),
nome_peca Texto(1),
descricao Texto(1),
preco Texto(1),
quant_estoque Texto(1)
)

CREATE TABLE veiculo (
id_veiculo Texto(1),
modelo Texto(1),
marca Texto(1),
ano Texto(1),
cor Texto(1),
placa Texto(1)
)

CREATE TABLE Relação_3 (

)

CREATE TABLE Relação_4 (

)

CREATE TABLE Relação_5 (

)

