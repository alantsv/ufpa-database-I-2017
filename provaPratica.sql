-- Universidade Federal do Pará
-- Instituto de Ciências Exatas e Naturais
-- Faculdade de Computação
-- Disciplina: Bando de Dados I
-- Professora: Fabiola P. Oliveira Araújo
-- Alunos: Alan Tony Souza Veloso, 201504940009
--		   Elton Peniche Quaresma, 201504940035
-- Período: 2017.2
-- Data: 05/09/2017

-- Entidades Fortes
create table Associado(
	CPF char(18) not null,
	RG varchar2(20) not null,
	Nome_Assoc varchar2(80) not null,
	Endereco_Assoc varchar2(100) null,
	Telefone_Assoc varchar2(10) null,
	Data_Nasc date null,
	constraint pk_Associado primary key (CPF)
);

create table Fa_Clube (
	Cod_Fa number(5) not null,
	Nome_Fa varchar2(80) not null,
	Endereco_Fa varchar2(100) null,
	Telefone varchar2(8) null,
	constraint pk_Fa_Clube primary key (Cod_Fa)
);

create table Promocao(
	Cod_Prom number(5) not null,
	Descricao_Prom varchar2(255) not null,
	Premios_Prom varchar2(255) not null,
	Cod_Fa number(5) null, -- foreign key
	constraint pk_Promocao primary key (Cod_Prom)
);

-- Entidades Fracas
create table Fa_Club_Assoc(
	Cod_Fa number(5) not null, -- foreign key
	CPF char(18) not null, -- foreign key
	constraint pk_Fa_Clube_Assoc primary key (Cod_Fa, CPF)
);

create table Promocao_Assoc(
	Cod_Prom number(5) not null, -- foreign key
	CPF char(18) not null, -- foreign key
	Vencedor varchar2(1) not null,
	constraint pk_Promocao_Assoc primary key (Cod_Prom, CPF)
);

alter table Promocao add constraint fk_Faclube_Promo foreign key (Cod_Fa)
references Fa_Clube(Cod_Fa) on delete cascade;

alter table Fa_Club_Assoc add constraint fk_Faclube_Faclube_Assoc foreign key (Cod_Fa)
references Fa_Clube(Cod_Fa) on delete cascade;

alter table Fa_Club_Assoc add constraint fk_Assoc_Faclube_Assoc foreign key (CPF)
references Associado(CPF) on delete cascade;

alter table Promocao_Assoc add constraint fk_Promo_Promo_Assoc foreign key (Cod_Prom)
references Promocao(Cod_Prom) on delete cascade;

alter table Promocao_Assoc add constraint fk_Assoc_Promo_Assoc foreign key (CPF)
references Associado(CPF) on delete cascade;

-- 2ª questão
-- a)
alter table Associado drop column RG;

-- b)
alter table Fa_Club_Assoc add Data_Assoc Date not null;
alter table Fa_Club_Assoc modify Data_Assoc default '01/01/01';

-- 3ª questão
insert into Associado values ('03236563627', 'Elton', 'Passagem Canarinho', '8353-6051', '14/02/1996');
insert into Associado values ('01617809209', 'Alan', 'Rua José Soares Montenegro', '9875-7758', '17/01/1995');
insert into Associado values ('14471547766', 'Leo', 'Marituba', '9451-5141', '04/10/1997');

insert into Fa_Clube values (01, 'Clube do Raul Seixas', 'Passagem Ivan Leão', '33248475');
insert into Fa_Clube values (02, 'Clube do Huberto', 'Infinita Highway', '33245741');

insert into Promocao values (10, 'Compre 3 camisas e ganhe um cupom', 'TV de plasma', 01);
insert into Promocao values (20, 'Compre 1 ingreço e ganhe 2 cupons', 'PC gamer', 02);

insert into Fa_Club_Assoc values (02, '01617809209', '04/09/17');
insert into Fa_Club_Assoc values (01, '03236563627','03/09/17');

insert into Promocao_Assoc values (10, '03236563627', '1');
insert into Promocao_Assoc values (20, '01617809209', '0');

-- 4ª questão
-- a)
select Cod_Prom, Descricao_Prom 
from Promocao
where Cod_Prom in (select Cod_Prom from Promocao_Assoc where CPF in (select CPF from Associado where Promocao_Assoc.CPF = Associado.CPF and Associado.Data_Nasc like '%95'));

-- b)
select Nome_Assoc from Associado where CPF not in (select CPF from Promocao_Assoc where Associado.CPF = Promocao_Assoc.CPF);

-- 5ª questão
-- a)
update Associado set Nome_Assoc='Vencedor' where CPF in (select CPF from Promocao_Assoc where Promocao_Assoc.Vencedor = '1');

-- b)
delete from Associado where CPF in (select CPF from Promocao_Assoc where Cod_Prom in (select Cod_Prom from Promocao where Promocao.Premios_Prom = 'PC gamer'));
