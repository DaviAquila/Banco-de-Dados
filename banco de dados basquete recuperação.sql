Create database basquete

use basquete

CREATE TABLE jogadores (
	id_jogador int NOT NULL identity(0,1),
	nome varchar(255),
	salario float,
	posicao varchar(255),
	dataNascimento date,
	id_regiao int,
	descricao varchar(255),
	PRIMARY KEY (id_jogador)
);

CREATE TABLE times(
	id_time int NOT NULL identity(0,1),
	id_jogador int,
	id_tecnico int,
	id_ginasio int,
	nome varchar(255),
	id_regiao int,
	titulos int,
	PRIMARY KEY (id_time)
);

CREATE TABLE regioes(
	id_regiao int NOT NULL identity(0,1),
	nome varchar(255),
	liga varchar(255),
	PRIMARY KEY(id_regiao),
);

CREATE TABLE ginasios(
	id_ginasio int NOT NULL identity(0, 1),
	nome varchar (255),
	id_regiao int,
	PRIMARY KEY(id_ginasio)
);

CREATE TABLE tecnicos(
	id_tecnico int NOT NULL identity(0, 1),
	nome varchar (255),
	idade int,
	atual_time varchar (255),
	salario float,
	PRIMARY KEY(id_tecnico)
);

ALTER TABLE jogadores ADD CONSTRAINT jogadores_fk0 FOREIGN KEY(id_regiao) REFERENCES regioes(id_regiao);

ALTER TABLE times ADD CONSTRAINT times_fk1 FOREIGN KEY(id_time) REFERENCES jogadores(id_jogador);

ALTER TABLE times ADD CONSTRAINT times_fk2 FOREIGN KEY(id_tecnico) REFERENCES tecnicos(id_tecnico);

ALTER TABLE times ADD CONSTRAINT times_fk3 FOREIGN KEY(id_ginasio) REFERENCES ginasios(id_ginasio);

ALTER TABLE times ADD CONSTRAINT times_fk4 FOREIGN KEY(id_regiao) REFERENCES regioes(id_regiao);

ALTER TABLE ginasios ADD CONSTRAINT ginasios_fk0 FOREIGN KEY(id_regiao) REFERENCES regioes(id_regiao);


select AVG(j.salario) as "Media salarial de jogadores", AVG(tc.salario) as "Media salarial de Tecnicos"  from times t inner join jogadores j on t.id_jogador = j.id_jogador inner join tecnicos tc on t.id_tecnico = tc.id_tecnico

SELECT nome,FORMAT (dataNascimento, 'dd-MM-yy') as date from jogadores

select t.nome as "nome do time", j.nome as "nome do jogador", j.posicao as "posicao jogador" from times t left join jogadores j on t.id_jogador = j.id_jogador

select nome as "nome do time", (select sum(salario) from jogadores j inner join times t on j.id_jogador = t.id_jogador) as "gastos" from times group by nome

select sum(id_jogador) as "Total de jogadores" from jogadores

select count(id_regiao) as "contador", nome as "Nome regioes" from regioes GROUP BY nome

select t.nome as "Nome do time", e.nome as "nome do ginasio", n.nome as "nome da regiao" from ginasios e inner join times t on e.id_ginasio = t.id_ginasio inner join regioes n on n.id_regiao = e.id_regiao ORDER BY t.nome, e.nome,n.nome ASC

select	max(salario) as "Salario maximo dos jogadores", min(salario) as "Salario minimo dos jogadores" from jogadores

SELECT nome from tecnicos where salario in(select max(salario) from tecnicos)

SELECT nome, id_regiao FROM regioes WHERE id_regiao NOT IN (1,2,3);

CREATE VIEW vwJogadores
as
	select nome,posicao,descricao,dataNascimento from jogadores

CREATE VIEW vwTimes
as
	select t.nome as "time",e.nome as "ginasio",n.nome as"regiao",titulos,tc.nome as"tecnico" from times t inner join ginasios e on t.id_ginasio = e.id_ginasio inner join regioes n on t.id_ginasio = n.id_regiao inner join tecnicos tc on tc.id_tecnico = t.id_tecnico

CREATE VIEW vwginasios
as
	select e.nome, n.nome as "ginasio" from ginasios e inner join regioes n on e.id_regiao = n.id_regiao
