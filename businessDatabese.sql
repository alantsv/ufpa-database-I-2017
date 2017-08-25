-- 1ª Criar as tabelas de acordo com a definição, definindo apenas a restrição de chave primária,
-- nomeando a mesma de acordo com o padrão (pk_nometabela).


-- Entidades fortes
--
create table Empregado
(rg varchar(15),
rg_supervisor varchar(15),
depto number(2),
nome varchar(50),
cpf char(11) not null,
salario number(6,2) not null,
constraint Pk_Emp primary key (rg));

create table Departamento
(numero number(2),
rg_gerente varchar(15),
nome varchar(40),
constraint Pk_Depto primary key (numero));

create table Projeto
(numero number(2),
rg_gerente varchar(15),
nome varchar(30) not null,
constraint Pk_Proj primary key (numero));

-- Entidades fracas
--
create table Dependente
(nome_dependente varchar(40),
rg_responsavel varchar(15),
nascimento DATE not null,
relacao varchar(20),
sexo char(1) not null,
constraint Pk_Dependete primary key(nome_dependente, rg_responsavel));

-- Reações M:N
--
create table Empregado_Projeto
(num_proj number(2),
rg_empregado varchar(15),
horas number not null,
constraint Pk_Emp_Proj primary key(num_proj, rg_empregado));

create table Departamento_Projeto
(num_depto number(2),
num_proj number(2),
constraint Pk_Depto_Proj primary key (num_depto, num_proj));

-- 2ª questão - Definir as chaves estrangeiras através do comando ALTER TABLE, colocando os nomes nas
-- restrições conforme informado nos respectivos relacionamentos.


alter table Empregado add constraint Fk_Emp_Emp foreign key (rg_supervisor) 
references Empregado(rg);

alter table Empregado add constraint Fk_Emp_Dept foreign key (depto) 
references Departamento(numero);

alter table Departamento add constraint Fk_Depto_Emp foreign key (rg_gerente) 
references Empregado(rg);

alter table Empregado_Projeto add constraint Fk_Emp_Proj foreign key (rg_empregado) 
references Empregado(rg)

-- 3ª questão - Efetuar as seguintes modificações na estrutura das tabelas: 
--
-- a) Adicionar o atributo data_ger na tabela de Departamento, sendo que o mesmo deve
-- ser do tipo DATE, não pode receber valor nulo e o seu valor default é sysdate (data
-- do sistema). 

alter table Departamento add data_get DATE not null;

alter table Departamento modify data_get default sysdate;

-- continuação
-- b) Retirar o atributo relacao da tabela de Dependente.

alter table Dependente drop column relacao;

-- c. Modificar o nome do Empregado para caracter variável de 70 posições
-- (varchar(70)).

alter table Empregado modify nome varchar(70);

-- d. Criar uma tabela de Localizacao_Depto como os atributos: numero_loc (number(2))
-- e nome_loc (vachar(30)). Em seguida fazer o relacionamento identificado entre 
-- Departamento e Localizacao_Depto, ou seja, a chave primária da tabela
-- Localizacao_Depto será o numero_loc mais numero da tabela Departamento.

create table Localizacao_Depto
(numero_loc number(2),
nome_loc varchar(30) not null,
num_depto number(2),
constraint Pk_Loc primary key (numero_loc, num_depto),
constraint Fk_Loc_Depto foreign key (num_depto)
references Departamento(numero));

-- e. Adicionar o atributo RG_Gerente_Proj na tabela Projeto, sendo que o mesmo é uma
-- chave estrangeira da tabela Empregado.

alter table Projeto add constraint Fk_Proj_Emp foreign key (rg_gerente)
references Empregado(rg);

-- 4) Inserir 5 linhas em cada tabela.

-- Data format: 25/08/17

-- Departamentos
-- (num_depto, rg_ger_depto, nome_depto)
insert into Departamento
values (01, null,  'Financeiro', default);

insert into Departamento
values (02, null,  'Contabilidade', '24/08/16');

insert into Departamento
values (03, null,  'Administração', '23/08/16');

insert into Departamento
values (04, null,  'Recursos Humandos', default);

insert into Departamento
values (05, null,  'TI', '01/01/01');

-- Empregados
-- (rg_emp, rg_ger_emp, num_depto_emp, cpf_emp, sal_emp)
insert into Empregado
values ('000001', null, null, 'João', '12345000000', 9000.00);

insert into Empregado
values ('000002', null, null, 'Cristina', '54123', 9.00);

insert into Empregado
values ('000003', null, null, 'Marcos', '54321', 9.00);

insert into Empregado
values ('000004', null, null, 'Pedro', '32145', 7.00);

insert into Empregado
values ('000005', null, null,'Carlos', '25413', 7.00);

-- Projetos
-- (num_proj, rg_ger_proj, nome_proj)
insert into Projeto
values(10, '000001', 'Pirapora');

insert into Projeto
values(11, '000001', 'Tucundubá');

insert into Projeto
values(12, '000001', 'Guama');

insert into Projeto
values(13, '000002', 'Amazonia');

insert into Projeto
values(14, '000003', 'Tucunare');

-- Dependentes
--(nome_depend, rg_resp_depend, nasc_depend, relacao_emp_depend, sex_depend)

insert into Dependente
values('Carla', '000001', nasc_depend, 'Filha', 'F');

insert into Dependente
values('Diana', '000001', nasc_depend, 'Filha', 'F');

insert into Dependente
values('Luan', '000002', nasc_depend, 'Filho', 'M');

insert into Dependente
values('Fernando', '000003', nasc_depend, 'Filho', 'M');

insert into Dependente
values('Luiz', '000004', nasc_depend, 'Filho', 'M');

-- Relacionamentos
-- Empregado_Projeto
-- (num_proj, rg_empr, horas_empr_proj)
