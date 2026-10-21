--Criação de Tabelas

create table engenheiros (
id serial primary key,
nome varchar(100) not null,
crea varchar(10) unique not null,
tempo_experiencia numeric(10,2) default 0 check (tempo_experiencia >= 0) not null
)

create table obras (
id serial primary key,
engenheiro_id int references engenheiros(id),
nome_obra varchar(100) not null,
cidade varchar(100) not null,
orcamento_previsto numeric(10,2) check (orcamento_previsto > 0) not null,
status varchar(100) default 'planejamento' check ( status in('planejamento', 'em execucao', 'concluida', 'pausada'))
);

create table fornecedores (
id serial primary key,
razao_social varchar(100) not null,
cnpj varchar(14) unique not null,
email varchar(100) unique not null
)

create table materiais (
id serial primary key,
fornecedor_id int references fornecedores(id),
nome_material varchar(100) not null,
preco_unitario numeric(10,2) check (preco_unitario > 0) not null,
unidade_medida varchar(100) default 'unidade' check (unidade_medida in('saco', 'metro', 'kg', 'unidade')) 
);

create table compras_material (
id serial primary key,
obra_id int references obras(id),
material_id int references materiais(id),
quantidade int not null check (quantidade > 0),
valor_pago numeric(10,2) not null check (valor_pago > 0),
data_compra timestamp default current_timestamp
)

--povoamento

insert into engenheiros(id, nome, crea)
values
('1', 'joao', '123456-D'),
('2', 'renato', '123457-D'),
('3', 'bia', '223456-D'),
('4', 'miguel', '123356-D'),
('5', 'wilson', '123256-D');

insert into fornecedores(id,razao_social, cnpj, email)
values
('1', '0','12345678910123', 'nm@email.com'),
('2', '1', '12345678910124', 'da@email.com'),
('3', '2', '12345678910125', 'lm@email.com'),
('4', '3', '12345678910126', 'we@email.com'),
('5', '4', '12345678910127', 'po@email.com')

insert into materiais (id, nome_material, preco_unitario)
values
('1', 'lampada', '30.00'),
('2', 'pc', '10.00'),
('3', 'garrafa', '5.00'),
('4', 'ampoula', '60.00'),
('5', 'mesa', '80.00');

insert into obras (id, nome_obra, cidade, orcamento_previsto)
values
('1', 'obra1', 'caldas novas', '10000'),
('2', 'obra2', 'sarandi', '20000'),
('3', 'obra3', 'floripa', '30000'),
('4', 'obra4', 'garopaba', '40000'),
('5', 'obra5', 'praia grande', '50000');

insert into compras_material (id, quantidade, valor_pago) 
values
('1', '5', '2000.00'),
('2', '19', '1000.00'),
('3', '4', '10.00'),
('4', '90', '1234.00'),
('5', '200', '919.00');

--Questões

--Q1

SELECT 
o.nome_obra, 
o.cidade, 
o.orcamento_previsto, 
e.nome AS nome_engenheiro, 
e.crea
FROM obras o
INNER JOIN engenheiros e ON o.engenheiro_id = e.id
WHERE o.status IN ('Planejamento', 'Em Execucao');

--view 1
create view vw_painel_obras as
select
o.nome_obra,
o.cidade,
o.status,
o.orcamento_previsto,
e.nome,
e.crea
from obras o
inner join engenheiros e ON o.engenheiro_id = e.id

