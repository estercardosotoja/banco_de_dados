# Procedure

É como uma função que fica armazenada dentro do banco de dados.
Uma procedure pode receber parâmetros, executar comandos SQL, utilizar variáveis, tomar decisões com `IF`, tratar erros com `EXCEPTION` e realizar operações como `INSERT`, `UPDATE` e `SELECT`.

## Sintaxe básica

```
    CREATE OR REPLACE PROCEDURE nome_procedure AS
        -- DECLARAÇÃO DE VARIÁVEIS
    BEGIN
        -- COMANDOS
    END;
    /
```

## Como executar uma procedure

```
    EXECUTE nome_procedure;
```

ou:

```
    EXEC nome_procedure;
```

### Criando a tabela `clientes`

Antes de criarmos as procedures, precisamos ter uma tabela para trabalhar.

```
    DROP TABLE clientes;

    CREATE TABLE clientes (
        id INTEGER PRIMARY KEY,
        nome VARCHAR2(100) NOT NULL,
        idade INTEGER NOT NULL
    );
```

### Criando uma procedure simples

Podemos criar uma procedure para cadastrar um cliente.
```
    CREATE OR REPLACE PROCEDURE cadastrar_cliente AS
    BEGIN
        INSERT INTO clientes ( id, nome, idade ) VALUES ( 1, 'João', 25);
        DBMS_OUTPUT.PUT_LINE( 'Cliente cadastrado com sucesso!' );
    END;
    /
```

### O que está acontecendo?

```
    CREATE OR REPLACE PROCEDURE cadastrar_cliente
```

`CREATE OR REPLACE PROCEDURE: ` Cria a procedure.

`cadastrar_cliente: ` O nome da procedure. 

`AS:` indica o início da declaração da procedure.

`BEGIN:` Indica o início dos comandos que serão executados.

`INSERT: ` Cadastra o cliente

`DBMS_OUTPUT.PUT_LINE:` Exibe uma mensagem

`SET SERVEROUTPUT ON; ` Comando para liberar o terminal para exibir a mensagem

### Executando

```
SET SERVEROUTPUT ON;
EXECUTE cadastrar_cliente;
```

Resultado:

```text
Cliente cadastrado com sucesso!
```

Podemos verificar:

```sql
SELECT * FROM clientes;
```

Resultado:

```text
ID    NOME    IDADE
1     João    25
```


## Procedure com parâmetros

A procedure anterior sempre cadastra o mesmo cliente.
Para permitir que o usuário informe os dados, podemos utilizar **parâmetros**.

```
    CREATE OR REPLACE PROCEDURE cadastrar_cliente (
        parametro_id INTEGER,
        parametro_nome VARCHAR2,
        parametro_idade INTEGER
    ) AS
    BEGIN
        INSERT INTO clientes ( id, nome, idade) VALUES ( parametro_id, parametro_nome, parametro_idade );
    END;
    /
```

Agora a procedure recebe três informações:

```
    parametro_id
    parametro_nome
    parametro_idade
```

Na execução:

```
EXECUTE cadastrar_cliente( 2, 'Maria', 30);
```

Os valores são enviados para os parâmetros:

```
    parametro_id     → 2
    parametro_nome   → Maria
    parametro_idade  → 30
```

Podemos cadastrar outro cliente:

```
    EXECUTE cadastrar_cliente( 3, 'Carlos', 40 );
```

E consultar:

```
    SELECT * FROM clientes;
```

Resultado:

```
ID    NOME      IDADE
1     João      25
2     Maria     30
3     Carlos    40
```

## Procedure com parâmetro `IN`

Podemos deixar explícito que o parâmetro é de entrada utilizando `IN`.

```
CREATE OR REPLACE PROCEDURE buscar_cliente (
    p_id IN NUMBER
) AS
```

O `IN` significa:

> O valor será recebido pela procedure. Por exemplo:

```
    EXECUTE buscar_cliente(1);
```

O número `1` será recebido pelo parâmetro:

```
    p_id = 1
```

## Variáveis dentro da procedure

Além dos parâmetros, uma procedure pode possuir **variáveis internas**.

```
    CREATE OR REPLACE PROCEDURE buscar_cliente (
        parametro_id IN NUMBER
    ) AS
        variavel_nome VARCHAR2(100);
    BEGIN
        SELECT nome INTO variavel_nome FROM clientes WHERE id = parametro_id;
        DBMS_OUTPUT.PUT_LINE(variavel_nome);
    END;
    /
```

Aqui temos:

```
    parametro_id
```
que é um **parâmetro** recebido pela procedure.
E:

```
    varaiavel_nome
```
que é uma **variável interna**.

Executando:

```sql
SET SERVEROUTPUT ON;

EXECUTE buscar_cliente(1);
```

Resultado:

```text
João
```

## `EXCEPTION` — tratamento de erros

E se tentarmos procurar um cliente que não existe?

```
    EXECUTE buscar_cliente(10);
```

O `SELECT INTO` não encontrará nenhum registro.

Nesse caso, podemos tratar o erro utilizando `EXCEPTION`.

### Sintaxe

```
    CREATE OR REPLACE PROCEDURE exemplo AS
    BEGIN
        -- comandos
    EXCEPTION
        -- tratamento do erro   
    END;
    /
```

# `EXCEPTION` com `NO_DATA_FOUND`

Vamos modificar a procedure:

```
    CREATE OR REPLACE PROCEDURE buscar_cliente (
        parametro_id IN NUMBER
    ) AS
        variavel_nome VARCHAR2(100);
    BEGIN
        SELECT nome INTO variavel_nome FROM clientes WHERE id = parametro_id;
        DBMS_OUTPUT.PUT_LINE( 'Cliente: ' || variavel_nome);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE( 'Cliente não encontrado.');
    END;
    /
```
Agora:
```
    SET SERVEROUTPUT ON;
    EXECUTE buscar_cliente(10);
```
Como o cliente `10` não existe:
```text
    Cliente não encontrado.
```

## Procedure para aumentar a idade
Podemos utilizar uma procedure para alterar a idade de um cliente.

```
    CREATE OR REPLACE PROCEDURE aumentar_idade (
        parametro_id IN NUMBER
    ) AS
        idade_atual NUMBER;
    BEGIN

        UPDATE clientes SET idade = idade + 1 WHERE id = parametro_id;
        SELECT idade  INTO idade_atual FROM clientes WHERE id = parametro_id;
        DBMS_OUTPUT.PUT_LINE( 'Idade atual: ' || idade_atual );
    END;
    /
```

Executando:

```sql
    SET SERVEROUTPUT ON;
    EXECUTE aumentar_idade(1);
```

Se João tinha:
```
    25 anos
```
passará a ter:

```
    26 anos
```

## Procedure com `IF`
O `IF` permite que a procedure **tome uma decisão**.

### Sintaxe

```
    IF condição THEN
        -- comandos
    END IF;
```

Podemos utilizar isso para verificar se uma idade é válida.
```
    CREATE OR REPLACE PROCEDURE atualizar_idade (
        parametro_id IN NUMBER,
        parametro_idade IN NUMBER
    ) AS
    BEGIN
        IF parametro_idade >= 0 THEN
            UPDATE clientes SET idade = parametro_idade WHERE id = parametro_id;
            DBMS_OUTPUT.PUT_LINE( 'Idade alterada para: ' ||
                parametro_idade );
        END IF;
    END;
    /
```
Executando:

```
    SET SERVEROUTPUT ON;
    EXECUTE atualizar_idade(2, 40);
```
Como:

```
40 >= 0
```
é verdadeiro, o `UPDATE` será executado.

## Criando a tabela `pedidos`

Agora podemos trabalhar com outra tabela.

```
CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY,
    cliente VARCHAR2(100),
    valor NUMBER(10,2)
);
```

# Procedure para criar pedido

Podemos criar uma procedure para inserir pedidos.

```
CREATE OR REPLACE PROCEDURE criar_pedido (
    parametro_id IN INTEGER,
    parametro_cliente IN VARCHAR2,
    parametro_valor IN NUMBER
) AS
BEGIN
    INSERT INTO pedidos ( id, cliente, valor ) VALUES ( parametro_id, parametro_cliente, parametro_valor);
    DBMS_OUTPUT.PUT_LINE('Pedido criado com sucesso!');
END;
/
```
Executando:

```
SET SERVEROUTPUT ON;
EXECUTE criar_pedido( 2, 'João', 150 );
```

### Adicionando `total_pedidos` aos clientes

Agora queremos saber **quantos pedidos cada cliente possui**.

Nossa tabela `clientes` ainda não possui essa informação.

Podemos adicionar uma nova coluna:

```
ALTER TABLE clientes
ADD total_pedidos NUMBER DEFAULT 0 NOT NULL;
```

### Procedure com `COMMIT`, `ROLLBACK` e `EXCEPTION`

Agora podemos criar uma procedure que faça **duas operações relacionadas**:

1. Criar o pedido.
2. Atualizar a quantidade de pedidos do cliente.

```
CREATE OR REPLACE PROCEDURE criar_pedido (
    parametro_id IN INTEGER,
    parametro_cliente_id IN INTEGER,
    parametro_cliente IN VARCHAR2,
    parametro_valor IN NUMBER
) AS
BEGIN
    -- Criar o pedido
    INSERT INTO pedidos ( id, cliente, valor )  VALUES ( parametro_id, parametro_cliente, parametro_valor);

    -- Atualizar quantidade de pedidos
    UPDATE clientes SET total_pedidos = total_pedidos + 1 WHERE id = parametro_cliente_id;

    -- Confirmar as alterações
    COMMIT;
    DBMS_OUTPUT.PUT_LINE( 'Pedido criado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        -- Desfazer as alterações
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE( 'Erro! Pedido não criado.');

END;
/ 
```

Neste exemplo:

```
    INSERT
    ↓
    UPDATE
    ↓
    COMMIT
    ↓
    ALTERAÇÕES CONFIRMADAS
```

Depois do `COMMIT`, as alterações são salvas.

O `ROLLBACK` desfaz as alterações que ainda não foram confirmadas.

No nosso exemplo, se ocorrer um erro antes do `COMMIT`:

```text
    INSERT
    ↓
    UPDATE
    ↓
    ERRO
    ↓
    EXCEPTION
    ↓
    ROLLBACK
    ↓
    DESFAZ AS ALTERAÇÕES
```

Assim, evitamos que uma parte da operação seja salva enquanto outra parte falha.

