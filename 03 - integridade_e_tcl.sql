-- NO ACTION 

PRAGMA foreign_keys = ON;

CREATE TABLE clientes (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL
);

	CREATE TABLE pedidos (
		id INTEGER PRIMARY KEY,
		cliente_id INTEGER NOT NULL,
		descricao TEXT NOT NULL,

		FOREIGN KEY (cliente_id)
			REFERENCES clientes(id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
	);

    INSERT INTO clientes (id, nome)
    VALUES
        (1, 'Maria'),
        (2, 'Joao');

    INSERT INTO pedidos (id, cliente_id, descricao)
    VALUES
        (1, 1, 'Agua'),
        (2, 1, 'Pao');


    DELETE FROM clientes
    WHERE id = 1;

    SELECT * FROM pedidos;
    SELECT * FROM clientes; 

-- CASCADE 

    PRAGMA foreign_keys = ON;

    CREATE TABLE clientes (
        id INTEGER PRIMARY KEY,
        nome TEXT NOT NULL
    );

    CREATE TABLE pedidos (
        id INTEGER PRIMARY KEY,
        cliente_id INTEGER NOT NULL,
        descricao TEXT NOT NULL,

        FOREIGN KEY (cliente_id)
            REFERENCES clientes(id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );

    INSERT INTO clientes (id, nome)
    VALUES
        (1, 'Maria'),
        (2, 'Joao');

    INSERT INTO pedidos (id, cliente_id, descricao)
    VALUES
        (1, 1, 'Agua'),
        (2, 1, 'Pao');


    DELETE FROM clientes
    WHERE id = 1;

    SELECT * FROM pedidos;
    SELECT * FROM clientes; 


-- SET NULL: 

PRAGMA foreign_keys = ON;

CREATE TABLE clientes (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    descricao TEXT NOT NULL,

    FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
        ON DELETE SET NULL
        ON UPDATE SET NULL
);

    INSERT INTO clientes (id, nome)
    VALUES
        (1, 'Maria'),
        (2, 'Joao');

    INSERT INTO pedidos (id, cliente_id, descricao)
    VALUES
        (1, 1, 'Agua'),
        (2, 1, 'Pao');


    DELETE FROM clientes
    WHERE id = 1;

    SELECT * FROM pedidos;
    SELECT * FROM clientes; 

-- SET DEFAULT NULL: 

PRAGMA foreign_keys = ON;
drop table pedidos;
drop table clientes;

 PRAGMA foreign_keys = ON;

    CREATE TABLE clientes (
        id INTEGER PRIMARY KEY,
        nome TEXT NOT NULL
    );

    CREATE TABLE pedidos (
        id INTEGER PRIMARY KEY,
        cliente_id INTEGER NOT NULL DEFAULT 0,
        descricao TEXT NOT NULL,

        FOREIGN KEY (cliente_id)
            REFERENCES clientes(id)
            ON DELETE SET DEFAULT
            ON UPDATE SET DEFAULT
    );

    INSERT INTO clientes (id, nome)
    VALUES
	    (0, 'Cliente não identificado'),
        (1, 'Maria'),
        (2, 'Joao');

    INSERT INTO pedidos (id, cliente_id, descricao)
    VALUES
        (1, 1, 'Agua'),
        (2, 1, 'Pao');


    DELETE FROM clientes WHERE id = 1;

    SELECT * FROM pedidos;
    SELECT * FROM clientes; 

-- CHECK

PRAGMA foreign_keys = ON;

CREATE TABLE clientes (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL
);


CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY,

    cliente_id INTEGER NOT NULL
        CHECK (cliente_id >= 0),

    descricao TEXT NOT NULL,

    FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
);


INSERT INTO clientes (id, nome)
VALUES
    (0, 'Cliente não identificado'),
    (1, 'Maria'),
    (2, 'Joao');


INSERT INTO pedidos (id, cliente_id, descricao)
VALUES
    (1, 1, 'Agua'),
    (2, 1, 'Pao');


SELECT * FROM pedidos;
SELECT * FROM clientes;

-- Isso irá funcionar:

INSERT INTO pedidos (id, cliente_id, descricao)
VALUES (3, 2, 'Leite');

-- Isso não irá funcionar porque há número negativo: 
INSERT INTO pedidos (id, cliente_id, descricao)
VALUES (4, -1, 'Cafe');

-- TRANSACTION

-- commit:

    CREATE TABLE CONTAS (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        saldo DECIMAL(10,2) NOT NULL
        );

    INSERT INTO CONTAS (id, nome, saldo) VALUES (1, "Maria", 1000.00);
    INSERT INTO CONTAS (id, nome, saldo) VALUES (2, "Joao", 500.00);

    SELECT * FROM CONTAS;

    BEGIN TRANSACTION;
    UPDATE CONTAS SET saldo = saldo - 200 where nome = 'Maria'; 
    UPDATE CONTAS SET saldo = saldo + 200 where nome = 'Joao'; 
    COMMIT TRANSACTION

    SELECT * FROM CONTAS;

-- rollback:

    CREATE TABLE CONTAS (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        saldo DECIMAL(10,2) NOT NULL
        );

    INSERT INTO CONTAS (id, nome, saldo) VALUES (1, "Maria", 1000.00);
    INSERT INTO CONTAS (id, nome, saldo) VALUES (2, "Joao", 500.00);

    SELECT * FROM CONTAS;

    BEGIN TRANSACTION;
    UPDATE CONTAS SET saldo = saldo - 200 where nome = 'Maria'; 
    UPDATE CONTAS SET saldo = saldo + 200 where nome = 'Joao'; 
    COMMIT TRANSACTION

    UPDATE CONTAS SET saldo = saldo - 200 where nome = 'Joao'; 
    ROLLBACK TRANSACTION 

    SELECT * FROM CONTAS;

-- savepoint: 

    CREATE TABLE CONTAS (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        saldo DECIMAL(10,2) NOT NULL
        );

    INSERT INTO CONTAS (id, nome, saldo) VALUES (1, "Maria", 1000.00);
    INSERT INTO CONTAS (id, nome, saldo) VALUES (2, "Joao", 500.00);

    SELECT * FROM CONTAS;

    BEGIN TRANSACTION;
    UPDATE CONTAS SET saldo = saldo - 200 where nome = 'Maria'; 
    UPDATE CONTAS SET saldo = saldo + 200 where nome = 'Joao'; 
    SAVEPOINT Ponto1;

    UPDATE CONTAS SET saldo = saldo - 200 where nome = 'Joao'; 
    ROLLBACK TRANSACTION Ponto1;

    SELECT * FROM CONTAS;