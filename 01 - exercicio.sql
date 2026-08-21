-- BD DA VILA DO CHAVES

-- Exercicio 1:  
CREATE TABLE moradores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT,
    idade INTEGER
);

-- Exercicio 2:
INSERT INTO moradores (nome, email, idade)
VALUES
    ('Chaves', 'chaves@gmail.com', 8),
    ('Chiquinha', 'chiquinha@gmail.com', 8),
    ('Quico', 'quico@gmail.com', 9),
    ('Seu Madruga', 'seumadruga@gmail.com', 50),
    ('Dona Florinda', 'donaflorinda@gmail.com', 45),
    ('Professor Girafales', 'girafales@gmail.com', 45),
    ('Dona Clotilde', 'donaclotilde@gmail.com', 60),
    ('Senhor Barriga', 'senhorbarriga@gmail.com', 50),
    ('Nhonho', 'nhonho@gmail.com', 10),
    ('Godinez', 'godinez@gmail.com', 12),
    ('Paty', 'paty@gmail.com', 9),
    ('Gloria', 'gloria@gmail.com', 35);


-- Exercicio 3:

-- 3.1 Mostrar todos os moradores

SELECT * FROM moradores;


-- 3.2 Mostrar somente nome e e-mail
SELECT nome, email
FROM moradores;


-- 3.3 Mostrar moradores com idade maior que 20

SELECT *
FROM moradores
WHERE idade > 20;


-- 3.4 Mostrar moradores com idade maior que 20
--     e menor que 50

SELECT *
FROM moradores
WHERE idade > 20
AND idade < 50;


-- 3.5 Mostrar moradores com idade menor que 18
--     OU maior que 40

SELECT *
FROM moradores
WHERE idade < 18
OR idade > 40;


-- 3.6 Mostrar moradores cujo nome começa com C

SELECT *
FROM moradores
WHERE nome LIKE 'C%';


-- 3.7 Mostrar moradores cujo nome termina com A

SELECT *
FROM moradores
WHERE nome LIKE '%a';


-- ============================================================
-- 4. RANKING DA VILA
-- ============================================================

-- 4.1 Do mais jovem para o mais velho

SELECT *
FROM moradores
ORDER BY idade ASC;


-- 4.2 Do mais velho para o mais jovem

SELECT *
FROM moradores
ORDER BY idade DESC;


-- 4.3 Mostrar somente os 3 moradores mais jovens

SELECT *
FROM moradores
ORDER BY idade ASC
LIMIT 3;


-- 4.4 Mostrar somente os 3 moradores mais velhos

SELECT *
FROM moradores
ORDER BY idade DESC
LIMIT 3;


-- ============================================================
-- 5. O PROBLEMA DO ALUGUEL
-- ============================================================

-- 5.1 Alterar o e-mail do Chaves

UPDATE moradores
SET email = 'chavesnovomail@gmail.com'
WHERE nome = 'Chaves';


-- 5.2 Alterar a idade da Chiquinha

UPDATE moradores
SET idade = 9
WHERE nome = 'Chiquinha';


-- 5.3 Alterar o nome e o e-mail da Bruxa do 71

UPDATE moradores
SET nome = 'Bruxa do 71',
    email = 'bruxado71@gmail.com'
WHERE nome = 'Dona Clotilde';


-- 5.4 Alterar a idade do Seu Madruga

UPDATE moradores
SET idade = 51
WHERE nome = 'Seu Madruga';


-- Conferir as alterações

SELECT *
FROM moradores;


-- ============================================================
-- 6. ALGUÉM DEIXOU A VILA!
-- ============================================================

-- Vamos remover o personagem Godinez

DELETE FROM moradores
WHERE nome = 'Godinez';


-- Conferir se foi removido

SELECT *
FROM moradores;


-- ============================================================
-- 7. A VILA GANHOU TELEFONE!
-- ============================================================

-- Adicionando a coluna telefone

ALTER TABLE moradores
ADD COLUMN telefone TEXT;


-- Cadastrando telefone de pelo menos 5 moradores

UPDATE moradores
SET telefone = '(51) 99999-1001'
WHERE nome = 'Chaves';

UPDATE moradores
SET telefone = '(51) 99999-1002'
WHERE nome = 'Chiquinha';

UPDATE moradores
SET telefone = '(51) 99999-1003'
WHERE nome = 'Quico';

UPDATE moradores
SET telefone = '(51) 99999-1004'
WHERE nome = 'Seu Madruga';

UPDATE moradores
SET telefone = '(51) 99999-1005'
WHERE nome = 'Dona Florinda';

UPDATE moradores
SET telefone = '(51) 99999-1006'
WHERE nome = 'Professor Girafales';


-- Conferir os telefones

SELECT nome, telefone
FROM moradores;


-- ============================================================
-- 8. CRIANDO AS ATIVIDADES DA VILA
-- ============================================================

CREATE TABLE atividades (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);


-- Cadastrando pelo menos 5 atividades

INSERT INTO atividades (nome)
VALUES
    ('Futebol'),
    ('Aula de Matemática'),
    ('Reunião da Vila'),
    ('Brincadeiras'),
    ('Aula de Espanhol');


-- Conferir atividades

SELECT *
FROM atividades;


-- ============================================================
-- 9. CRIANDO A TABELA DE PARTICIPAÇÕES
-- ============================================================

CREATE TABLE participacoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    morador_id INTEGER,
    atividade_id INTEGER,

    FOREIGN KEY (morador_id)
        REFERENCES moradores(id),

    FOREIGN KEY (atividade_id)
        REFERENCES atividades(id)
);


-- ============================================================
-- CADASTRANDO 10 PARTICIPAÇÕES
-- ============================================================

-- Chaves -> Futebol
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (1, 1);

-- Chiquinha -> Futebol
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (2, 1);

-- Quico -> Aula de Matemática
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (3, 2);

-- Professor Girafales -> Aula de Matemática
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (6, 2);

-- Dona Florinda -> Reunião da Vila
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (5, 3);

-- Seu Madruga -> Reunião da Vila
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (4, 3);

-- Chaves -> Brincadeiras
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (1, 4);

-- Quico -> Brincadeiras
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (3, 4);

-- Chiquinha -> Aula de Espanhol
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (2, 5);

-- Professor Girafales -> Reunião da Vila
INSERT INTO participacoes (morador_id, atividade_id)
VALUES (6, 3);


-- Conferir as participações

SELECT *
FROM participacoes;


-- ============================================================
-- 10. QUAIS MORADORES PARTICIPAM DE QUAIS ATIVIDADES?
-- ============================================================

SELECT
    moradores.nome AS morador,
    atividades.nome AS atividade
FROM participacoes
JOIN moradores
    ON participacoes.morador_id = moradores.id
JOIN atividades
    ON participacoes.atividade_id = atividades.id;


-- ============================================================
-- 11. INVESTIGAÇÃO ESPECIAL
-- ============================================================

-- 11.1 Somente moradores que participam de Futebol

SELECT
    moradores.nome AS morador,
    atividades.nome AS atividade
FROM participacoes
JOIN moradores
    ON participacoes.morador_id = moradores.id
JOIN atividades
    ON participacoes.atividade_id = atividades.id
WHERE atividades.nome = 'Futebol';


-- 11.2 Todos os moradores e suas respectivas atividades

SELECT
    moradores.nome AS morador,
    atividades.nome AS atividade
FROM participacoes
JOIN moradores
    ON participacoes.morador_id = moradores.id
JOIN atividades
    ON participacoes.atividade_id = atividades.id
ORDER BY moradores.nome;


-- ============================================================
-- 12. ESTATÍSTICAS DA VILA
-- ============================================================


-- 12.1 Quantos moradores existem?

SELECT COUNT(*) AS quantidade_moradores
FROM moradores;


-- 12.2 Qual é a maior idade?

SELECT MAX(idade) AS maior_idade
FROM moradores;


-- 12.3 Qual é a menor idade?

SELECT MIN(idade) AS menor_idade
FROM moradores;


-- 12.4 Qual é a idade média dos moradores?

SELECT AVG(idade) AS idade_media
FROM moradores;


-- 12.5 Qual é a soma das idades?

SELECT SUM(idade) AS soma_idades
FROM moradores;


-- 12.6 Quantos moradores possuem cada idade?

SELECT
    idade,
    COUNT(*) AS quantidade
FROM moradores
GROUP BY idade
ORDER BY idade;


-- ============================================================
-- DESAFIO EXTRA
-- ============================================================

-- Quantos participantes existem em cada atividade?

SELECT
    atividades.nome AS atividade,
    COUNT(participacoes.morador_id) AS quantidade_participantes
FROM atividades
JOIN participacoes
    ON atividades.id = participacoes.atividade_id
GROUP BY atividades.nome;


-- Qual atividade possui mais participantes?

SELECT
    atividades.nome AS atividade,
    COUNT(participacoes.morador_id) AS quantidade_participantes
FROM atividades
JOIN participacoes
    ON atividades.id = participacoes.atividade_id
GROUP BY atividades.nome
ORDER BY quantidade_participantes DESC
LIMIT 1;


-- Quais moradores participam de mais de uma atividade?

SELECT
    moradores.nome AS morador,
    COUNT(participacoes.atividade_id) AS quantidade_atividades
FROM moradores
JOIN participacoes
    ON moradores.id = participacoes.morador_id
GROUP BY moradores.id
HAVING COUNT(participacoes.atividade_id) > 1;