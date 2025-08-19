-- criando o banco de dados solar
create database if not exists solar;
use solar;

-- tabela clientes
create table if not exists clientes (
    cod_cliente int not null auto_increment,  -- código do cliente
    nome_cliente varchar(100),                -- nome do cliente
    cpf varchar(14) not null,                 -- cpf do cliente
    endereco varchar(100),                    -- endereço do cliente
    celular varchar(19),                      -- celular do cliente
    primary key (cod_cliente)                 -- chave primária
);

-- tabela fornecedor
create table if not exists fornecedor (
    cod_fornecedor int not null auto_increment, -- código do fornecedor
    nome_fornecedor varchar(100),               -- nome do fornecedor
    cnpj varchar(18) not null,                  -- cnpj do fornecedor
    endereco varchar(100),                      -- endereço do fornecedor
    celular varchar(19),                        -- celular do fornecedor
    primary key (cod_fornecedor)                -- chave primária
);

-- tabela produto
create table if not exists produto (
    cod_produto int not null auto_increment,    -- código do produto
    nome_produto varchar(100),                  -- nome do produto
    valor decimal(10,2),                        -- valor do produto
    descricao varchar(100),                      -- descrição do produto
    quantidade_produto int,                      -- quantidade em estoque
    cod_fornecedor int not null,                 -- código do fornecedor
    primary key (cod_produto),                   -- chave primária
    foreign key (cod_fornecedor) references fornecedor(cod_fornecedor) -- relaciona produto ao fornecedor
);

-- tabela venda
create table if not exists venda (
    cod_venda int not null auto_increment,      -- código da venda
    cod_produto int not null,                   -- produto vendido
    cod_fornecedor int not null,                -- fornecedor do produto
    primary key (cod_venda),                    -- chave primária
    foreign key (cod_produto) references produto(cod_produto),
    foreign key (cod_fornecedor) references fornecedor(cod_fornecedor)
);

-- tabela departamento
create table if not exists departamento (
    cod_departamento int not null auto_increment,  -- código do departamento
    nome_departamento varchar(100) not null,       -- nome do departamento
    primary key (cod_departamento)                 -- chave primária
);

-- tabela funcionarios
create table if not exists funcionarios (
    cod_funcionario int not null auto_increment primary key,   -- código do funcionário
    nome_funcionario varchar(100) not null,                    -- nome do funcionário
    cargo varchar(100),                                        -- cargo do funcionário
    cpf_funcionario varchar(14),
    endereco_funcionario varchar(100),
    data_nascimento datetime not null,
    data_admissao datetime not null,
    data_rescisao datetime not null,
    salario decimal(10,2),                                     -- salário do funcionário
    cod_departamento int not null,                              -- código do departamento
    foreign key (cod_departamento) references departamento(cod_departamento) -- relaciona funcionário ao departamento
);

-- ---------------------------------------------------------------
-- consultar tabela funcionarios
select * from funcionarios;

-- alterações em tabelas

-- 1️⃣ adiciona coluna sexo
alter table funcionarios
add column sexo char(1);

-- 2️⃣ remove coluna sexo
alter table funcionarios
drop column sexo;

-- 3️⃣ renomeia a tabela para empregado
alter table funcionarios
rename to empregado;

-- 4️⃣ renomeia a coluna cpf_funcionario para cic_funcionario
alter table empregado
change column cpf_funcionario cic_funcionario varchar(18);

-- 5️⃣ adiciona coluna estado com valor padrão
alter table empregado
add column estado char(2) default 'mg';


-- --------------------------------------------------------------------------------------


alter table empregado
add primary key (cpf_funcionario); -- a tabela já possui uma primary key, isso não vai funcionar

-- ao invés faça isso:alter table empregado
alter table empregado
drop primary key,
add primary key (cpf_funcionario);


