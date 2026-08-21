DROP TABLE clientes;

CREATE TABLE clientes (
    id INTEGER PRIMARY KEY, 
    nome VARCHAR2(100) NOT NULL,
    idade INTEGER NOT NULL
);

-- Criação da procedure: 
CREATE OR REPLACE PROCEDURE cadastrar_cliente AS
BEGIN
    INSERT INTO clientes (id, nome, idade) VALUES (1, 'João', 25);
    DBMS_OUTPUT.PUT_LINE('Cliente cadastrado com sucesso!');
END;

SET SERVEROUTPUT ON;
EXECUTE cadastrar_cliente;

SELECT * FROM clientes;

-- Adicionando clientes pela procudure por parametros: 
CREATE OR REPLACE PROCEDURE cadastrar_cliente(
    parametro_id INTEGER,
    parametro_nome VARCHAR2,
    parametro_idade INTEGER
) AS
BEGIN
    INSERT INTO clientes (id, nome, idade) VALUES (parametro_id, parametro_nome, parametro_idade);
END;

SET SERVEROUTPUT ON;
EXECUTE cadastrar_cliente(2, 'Maria', 30);
EXECUTE cadastrar_cliente(3, 'Carlos', 40);

SELECT * FROM clientes;

--------------------- 

CREATE OR REPLACE PROCEDURE buscar_cliente (
    p_id IN NUMBER --PARAMETRO (DEVE SER PASSADO NA EXECUÇÃO DA PROCEDURE) 
) AS
    v_nome VARCHAR2(100); -- VARIAVEL INTERNA, USADA DENTRO DA PROCEDURE; 
BEGIN
    SELECT nome INTO v_nome FROM clientes WHERE id = p_id;
    DBMS_OUTPUT.PUT_LINE(v_nome);
END;
/
SET SERVEROUTPUT ON;
EXECUTE buscar_cliente(1);

SET SERVEROUTPUT ON;
EXECUTE buscar_cliente(3);



-- E o EXCEPTION? E quando não há um dado da consulta na tabela.
/* Sintaxe: 

CREATE OR REPLACE PROCEDURE exemplo AS
BEGIN
    -- comandos
EXCEPTION
    -- tratamento do erro
END;
/

*/ 

-- Na busca por cliente 
CREATE OR REPLACE PROCEDURE buscar_cliente (
    parametro_id IN NUMBER
) AS
    variavel_nome VARCHAR2(100);
BEGIN
    SELECT nome INTO variavel_nome FROM clientes WHERE id = parametro_id;
    DBMS_OUTPUT.PUT_LINE('Cliente: ' || variavel_nome);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Cliente não encontrado.');
END;
/

SET SERVEROUTPUT ON;
execute buscar_cliente(10);

CREATE OR REPLACE PROCEDURE aumentar_idade (
    parametro_id IN NUMBER
) AS
    idade_atual NUMBER;
BEGIN
    UPDATE clientes  SET idade = idade + 1 WHERE id = parametro_id;
    SELECT idade  INTO idade_atual  FROM clientes  WHERE id = parametro_id;
    DBMS_OUTPUT.PUT_LINE( 'Idade atual: ' || idade_atual );
END;
/
SET SERVEROUTPUT ON;
execute aumentar_idade(1);

SELECT * FROM CLIENTES;

-- Procedures com if: 
CREATE OR REPLACE PROCEDURE atualizar_idade (
    parametro_id IN NUMBER,
    parametro_idade IN NUMBER
) AS
BEGIN
    IF parametro_idade >= 0 THEN
        UPDATE clientes   SET idade = parametro_idade  WHERE id = parametro_id;
        DBMS_OUTPUT.PUT_LINE( 'Idade alterada para: ' || parametro_idade );
    END IF;
END;
/
       
        SET SERVEROUTPUT ON;
    EXECUTE atualizar_idade(2, 40);

SET SERVEROUTPUT ON;
EXECUTE  aumentar_idade(1, 10);

CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY, 
    cliente VARCHAR2(100),
    valor NUMBER(10,2)
);

--- CRIAR PEDIDOS 

CREATE OR REPLACE PROCEDURE criar_pedido (
    parametro_id IN INTEGER,
    parametro_cliente IN VARCHAR2,
    parametro_valor IN NUMBER
) AS
BEGIN
    INSERT INTO pedidos (id, cliente, valor) VALUES (parametro_id, parametro_cliente, parametro_valor);
            DBMS_OUTPUT.PUT_LINE( 'Pedido criado com sucesso!' );
END;
/

SET SERVEROUTPUT ON;
EXECUTE criar_pedido(2, 'João', 150);



--- ADICIONAR UMA COLUNA EM TABLEA DE CLIENTE PARA TER A QUANTIDADE DE PEDIDOS POR CLIENTE 
ALTER TABLE clientes ADD total_pedidos NUMBER DEFAULT 0 NOT NULL;


-- CRIAR O PEDIDO E GERAR UMA EXCESSÃO E USO DE ROLLBACK E COMMIT: 
CREATE OR REPLACE PROCEDURE criar_pedido (
    parametro_id IN INTEGER,
    parametro_cliente_id IN INTEGER,
    parametro_cliente IN VARCHAR2,
    parametro_valor IN NUMBER
) AS
BEGIN
    INSERT INTO pedidos (id, cliente, valor) VALUES (parametro_id, parametro_cliente, parametro_valor);
    UPDATE clientes SET total_pedidos = total_pedidos + 1 WHERE id = parametro_cliente_id;
    COMMIT; -- Salvar as alterações até aqui 
    DBMS_OUTPUT.PUT_LINE('Pedido criado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        -- Desfaz as operações 
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro! Pedido não criado.');
END;
/

SET SERVEROUTPUT ON
EXECUTE criar_pedido(3, 1, 'João', 300);

-- Consulta
SELECT * FROM clientes;
SELECT * FROM pedidos;