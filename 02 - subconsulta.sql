-- Operadores Lógicos

-- AND;
SELECT * FROM moradores WHERE idade > 20 AND idade < 50; 
 -- Mostrar os moradores com idade maior que 20 e menor que 50. E as duas condições são verdadeiras.

-- OR;
SELECT * FROM moradores WHERE idade < 18 OR idade > 40;
 -- Mostrar moradores com idade menor que 18 ou maior que 40. Quando pelo menos uma das condições é verdadeira.

-- NOT; 
SELECT * FROM moradores WHERE NOT idade > 40; 
-- o NOT inverte o resultado de uma condição. Mostrar todos os moradores que não possuem idade maior que 40.

-- IN; 
SELECT * FROM moradores WHERE nome IN ('Chaves', 'Quico', 'Chiquinha');
-- O operador IN verifica se um valor pertence a uma lista de valores. Ele é uma forma mais simples de escrever várias condições utilizando OR.


-- SUBCONSULTAS: 
/*
    Imagine que preciso obter a seguinte questão:
    "Mostre o nome dos moradores cujo ID está na lista de participantes da atividade cujo nome é Futebol."
*/
-- 1° Descubra qual é o ID da atividade Futebol.

    SELECT MAX(idade) FROM moradores;

-- 2° Descubra quais moradores participam dessa atividade.
    SELECT nome FROM moradores WHERE idade = ('resultado da consulta 1°')

-- 3° Busque os nomes desses moradores.
    SELECT nome FROM moradores WHERE id IN('resultado da consulta 2°')


/*
    Invès de ter que realizar três consultas para chegar em um resultado. Posso realizar subconsultas: 
*/ 
SELECT nome FROM moradores WHERE id IN(
	SELECT morador_id 	FROM participacoes 
	WHERE atividade_id IN (
		SELECT id FROM atividades 
		WHERE nome = 'Futebol')
		);  