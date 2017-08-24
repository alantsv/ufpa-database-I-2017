-- Entidades fortes
--
create table Empregado
(rg varchar(15),
rg_supervisor varchar(15),
depto number(2),
nome varchar(50),
cpf char(11) not null,
salario number(6,2) not null,
constraint Pk_Emp primary key (rg)
constraint Fk_Emp_Dept foreign key (depto)
references Departamento (numero));

create table Departamento
(numero number(2),
rg_gerente varchar(15),
nome varchar(40),
constraint Pk_Depto primary key (numero),
constraint Fk_Depto_Emp foreign key (rg_gerente)
references Empregado (rg));

create table Projeto
(numero number(2),
nome varchar(30) not null,
localizacao varchar(40) not null,
constraint Pk_Proj primary key (numero));

-- Entidades fracas
--
create table Dependente
(nome_dependente varchar(40),
rg_responsavel varchar(15),
nascimento DATE not null,
relacao varchar(20),
sexo char(1) not null,
constraint Pk_Dependete primary key(nome_dependente, rg_responsavel),
constraint Fk_Depend_Emp foreign key (rg_responsavel) 
references Empregado(rg));

-- Reações M:N
--
create table Empregado_Projeto
(num_proj number(2),
rg_empregado varchar(15),
horas number not null,
constraint Pk_Emp_Proj primary key(num_proj, rg_empregado),
constraint Fk_Emp foreign key (rg_empregado)
references Empregado (rg),
constraint Fk_Proj foreign key (num_proj)
references Projeto(numero));

create table Departamento_Projeto
(num_depto number(2),
num_proj number(2),
constraint Pk_Depto_Proj primary key (num_depto, num_proj),
constraint Fk_Depto foreign key (num_depto)
references Departamento(numero),
constraint Fk_Depto_Proj foreign key (num_proj)
references Projeto(numero));

-- 2º questão
--
-- alter table Empregado add constraint Fk_Emp_Emp foreign key (rg_supervisor) references Empregado(rg);

-- alter table Empregado add constraint Fk_Emp_Dept foreign key (depto) references Departamento(numero);

-- alter table Departamento add constraint Fk_Depto_Emp foreign key (rg_gerente) references Empregado(rg);


-- 3º questão
--
-- a) Adicionar o atributo data_ger na tabela de Departamento, sendo que o mesmo deve
-- ser do tipo DATE, não pode receber valor nulo e o seu valor default é sysdate (data
-- do sistema). 

-- alter table Departamento add data_get DATE not null;

-- alter table Departamento modify data_get default sysdate;


--


