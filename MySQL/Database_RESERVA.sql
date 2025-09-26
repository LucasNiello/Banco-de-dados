-- criar banco de dados
create database if not exists reserva_equipamentos;
use reserva_equipamentos;

-- tabela equipamento
create table if not exists equipamento (
    id_equipamento int not null auto_increment primary key,
    nome varchar(100) not null,
    tipo varchar(50),
    descricao varchar(200)
);

-- tabela usuario
create table if not exists usuario (
    id_usuario int not null auto_increment primary key,
    nome varchar(100) not null,
    email varchar(100) not null unique
);

-- tabela reserva
create table if not exists reserva (
    id_reserva int not null auto_increment primary key,
    id_equipamento int not null,
    id_usuario int not null,
    data_inicio datetime not null,
    data_fim datetime not null,
    status varchar(20) default 'reservado',
    foreign key (id_equipamento) references equipamento(id_equipamento),
    foreign key (id_usuario) references usuario(id_usuario)
);
