	--- Criar tabela; 
	CREATE TABLE alunos(
		id INTEGER PRIMARY KEY AUTOINCREMENT, 
		nome TEXT NOT NULL,
		email TEXT,
		idade INTEGER
	);

	-- Inserir dados; 

	INSERT INTO alunos(nome, email, idade)
	VALUES ('Paulo',  'paulo@gmail.com', 20);

	INSERT INTO alunos(nome, email, idade)
	VALUES ('Tiago',  'tiago@gmail.com', 10),
		('Joao',  'joao@gmail.com', 30),
		('Pedro',  'pedro@gmail.com', 40),
		('Lucas',  'lucas@gmail.com', 25);

	-- Consultar dados: 
	SELECT * FROM alunos;

	SELECT nome, email FROM alunos;

	SELECT nome, idade FROM alunos WHERE idade > 20 AND idade < 50;

	SELECT nome, idade FROM alunos WHERE idade > 20 OR idade < 50; 

	SELECT * FROM alunos WHERE nome LIKE 'P%'; 
	SELECT * FROM alunos WHERE nome LIKE '%o';

	-- Ordenar; 
	-- ASC = crescente; 
	-- DESC = decresecente; 

	SELECT * FROM alunos ORDER BY idade ASC; 
	SELECT * FROM alunos ORDER BY idade DESC; 

	-- LIMIT; 
	SELECT * FROM alunos ORDER BY idade LIMIT 2; 

	-- ALTERANDO DADOS;
	UPDATE alunos SET idade=21 where id=1; 

	UPDATE alunos SET nome = "Judas", email="judastraiu@gmail.com" WHERE id = 1;

	UPDATE alunos SET idade = 21;

	-- DELETA DADOS;

	DELETE FROM alunos WHERE id =5; 

	-- DELETAR TABELA;

	DROP TABLE alunos; 

	DELETE FROM alunos;

	-- ALTERAR TABELA: 

	ALTER TABLE alunos 
	ADD COLUMN telefone TEXT;

	-- ALTERAR NOME DE TABELA; 
	ALTER TABLE alunos 
	RENAME TO estudantes; 

	-- REMOVER VALORES REPETIDOS;
	INSERT INTO alunos(nome, email, idade)
	VALUES ('Matheus',  'matheus@gmail.com', 10),
		('Marcos',  'marcos@gmail.com', 30),
		('Simao',  'simao@gmail.com', 40),
		('Felipe',  'felipe@gmail.com', 25);

	SELECT DISTINCT idade FROM alunos; 

	-- CONTAR REGISTROS;

	SELECT COUNT(*) AS quantidade FROM alunos; 

	-- Operadores: 
	SELECT MAX(idade) FROM alunos; 
	SELECT MIN(idade) FROM alunos;
	SELECT AVG(idade) FROM alunos;
	SELECT SUM(idade) FROM alunos;

	-- Agrupadores 
	SELECT idade , COUNT(*) AS quantidade FROM alunos GROUP BY idade; 

	-- HAVING: Filtrar grupos: 

	SELECT idade, COUNT(*) AS quantidade FROM alunos 
	GROUP BY idade HAVING COUNT(*) > 1;

	-- CRIAR SEGUNDA TABELA

	CREATE TABLE cursos (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		nome TEXT NOT NULL
		);
		
	INSERT INTO cursos(nome) 
	VALUES ('Informatica'), ('Administração'), ('Eletrônica');

	CREATE TABLE matriculas(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		aluno_id INTEGER,
		curso_id INTEGER,
		FOREIGN KEY (aluno_id) REFERENCES alunos(id),
		FOREIGN KEY (curso_id) REFERENCES cursos(id)
		);
		
	INSERT INTO matriculas (aluno_id, curso_id) 
	VALUES (1 ,1), 
		(2 ,1),
		(3 ,2),
		(4 ,1),
		(5 ,2),
		(6 ,2),
		(7 ,1);
		
	SELECT * FROM matriculas;

	-- JOIN = Consultar informações de várias tabelas;

	SELECT alunos.nome AS aluno , cursos.nome AS curso FROM matriculas 
	JOIN alunos ON matriculas.aluno_id = alunos.id 
	JOIN cursos ON matriculas.curso_id = cursos.id
	WHERE cursos.nome = 'Informatica'; 
