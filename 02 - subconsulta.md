# Subconsulta (Subquery)

## Operadores Lógicos em SQL

Os coperadores lógicos são utilizados na cláusula `WHERE` para combinar, negar ou comparar condições em uma consulta SQL.

### - **AND**
Retorna verdadeiro somente quando todas as condições são verdadeiras. É utilizado quando desejamos que um registro atenda a mais de um critério ao mesmo tempo.

### - **OR**

Retorna verdadeiro quando pelo menos uma das condições é verdadeira. É utilizado quando basta que um dos critérios seja atendido.

### - **NOT**

Inverte o resultado de uma condição. Ou seja, seleciona os registros que não atendem ao critério especificado.

### - **IN**

Verifica se um valor pertence a uma lista de valores ou ao resultado de uma subconsulta. Ele é uma forma simplificada de escrever várias comparações com `OR`.

## Subconsulta (Subquery)

Uma subconsulta é uma consulta SQL executada dentro de outra consulta.
Ela serve para quando o resultado de uma consulta depende do resultado de outra.

```
    SELECT ...
    FROM tabela
    WHERE campo IN (
        SELECT ...
        FROM outra_tabela
    );
```

O SQL sempre executa:
- A consulta interna.
- A consulta externa utilizando o resultado da primeira.

Exemplo: Encontrar o(s) morador(es) mais velho(s):

1° Faremos uma consulta para descobrir qual a maior idade:
```
    SELECT MAX(idade) FROM moradores;
```
2°  Depois, uma segunda consulta para saber qual o nome: 

```
    SELECT * FROM moradores WHERE idade = 60;
```

Podemos fazer tudo em uma única consulta utilizando uma subconsulta.
```
    SELECT * FROM moradores WHERE idade IN ( SELECT MAX(idade) FROM moradores );
```

## Atualizar com Subconsulta: 

Atualizar o telefone dos moradores mais velhos

Imagine que queremos cadastrar um telefone especial para todos os moradores que possuem a maior idade.

```
    UPDATE moradores
    SET telefone = '(51) 99999-9999'
    WHERE idade IN (
        SELECT MAX(idade)
        FROM moradores
    );
```


## Deletar com Subconsulta: 

Remover o morador com maior id.
Imagine que queremos excluir o morador mais velho da vila.

```
    DELETE FROM moradores
    WHERE id IN (
        SELECT MAX(id)
        FROM moradores
    );
```


### Subsconsultas encadeadas: 

Queremos listar apenas os moradores que participam do Futebol.
1° Primeiro descobrimos qual é o código da atividade Futebol.

Como o SQL executa?

1° Consulta o id da atividade Futebol: 

```
    SELECT id FROM atividades WHERE nome='Futebol';
```

2° Consulta o id de quem participi das atividades 1: 

```
    SELECT morador_id FROM participacoes WHERE atividade_id IN (1);
```

3° Consulta em moradores qual o nome que possui os ids:

```
    SELECT * FROM moradores WHERE id IN (1,2);
```

Tudo isso em somente uma consulta: 

```
    SELECT id FROM atividades WHERE nome='Futebol';
```

Agora utilizamos esse resultado.

```
    SELECT *
    FROM moradores
    WHERE id IN (
        SELECT morador_id
        FROM participacoes
        WHERE atividade_id IN (
            SELECT id
            FROM atividades
            WHERE nome='Futebol'
        )
    );
```
