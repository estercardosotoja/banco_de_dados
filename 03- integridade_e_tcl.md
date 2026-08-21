# Integridade e TCL

## NO ACTION

Ele impede que uma alteração ou exclusão que quebre a integridade referencial seja realizada.

```
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
```

#### DELETE:

Tentamos:  ``` DELETE FROM clientes WHERE id = 1; ```
O banco impede a exclusão.
Por quê: Existem pedidos apontando para o cliente 1.

#### UPADATE:

Tentamos: ``` UPDATE clientes SET id = 10 WHERE id = 1; ```
O banco impede a alteração:
Por quê: Temos o cliente 10, que é uma referência para um cliente que não existe.

## CASCADE significa

Propagar a operação para os registros relacionados.

```
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
```

#### DELETE:

Executamos: ``` DELETE FROM clientes WHERE id = 1; ```
O banco exclui: O registro Maria da tabela de clientes e os pedidos relacionados a esse cliente_id .

#### UPADATE:

Executamos: ``` UPDATE clientes SET id = 10 WHERE id = 1; ```
O banco também atualiza a tabela de clientes e os pedidos relacionados a ao cliente_id:

## SET NULL

Quando o registro pai for excluído ou alterado, coloque NULL na chave estrangeira.

```
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
```

#### DELETE:
Executamos: ``` DELETE FROM clientes WHERE id = 1; ```
O cliente será excluído. Mas os pedidos não serão excluídos. O banco transforma cliente_id em NULL na tabela de pedidos.

## SET DEFAULT NULL

Quando o registro pai for excluído ou alterado, a chave estrangeira recebe o valor padrão definido na coluna.

```
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
```

#### DELETE:

Executamos: ``` DELETE FROM clientes WHERE id = 1; ```
Os pedidos continuam existindo, mas cliente_id recebe o valor padrão 0:

## CHECK

CHECK permite estabelecer uma condição que o dado precisa respeitar.

```
    CREATE TABLE clientes (
        id INTEGER PRIMARY KEY,
        nome TEXT NOT NULL,
        idade INTEGER CHECK (idade >= 0 AND idade <= 120),
        saldo REAL CHECK (aluguel >= 0)
    );
```

Executamos: ``` INSERT INTO clientes (nome, idade, saldo) VALUES ('Kiko', -5, 300.00); ```
A idade -5 não atende à regra definida no CHECK. Irá apresentar a mensagem de CHECK constraint failed: idade >= 0 AND idade <= 120. 

## TRANSACTION

Uma transação é um conjunto de operações que devem ser tratadas como uma única operação lógica. A ideia é: Ou fazemos tudo corretamente ou desfazemos a operação.

### Para que serve transaction?

Imagine uma venda:

Cliente compra 5 cadernos Precisamos:  

    1. Diminuir estoque;
    2. Registrar pedido;
    3. Registrar item do pedido;

Sem transação:

    Estoque diminuído
    Pedido falhou

Resultado:

    estoque errado
    venda não registrada

Com transação:

    BEGIN TRANSACTION;
    -- diminuir estoque
    -- criar pedido
    -- criar item

#### COMMIT:

Confirmar definitivamente as alterações da transação.

    ```
        BEGIN TRANSACTION;
        
        UPDATE CONTAS SET saldo = saldo - 200 where nome = 'Maria';
        UPDATE CONTAS SET saldo = saldo + 200 where nome = 'Joao';

        COMMIT TRANSACTION;
    ```

#### ROLLBACK

Desfazer as alterações realizadas na transação.

    ```
        BEGIN TRANSACTION;
        
        UPDATE CONTAS SET saldo = saldo - 200 where nome = 'Maria';
        UPDATE CONTAS SET saldo = saldo + 200 where nome = 'Joao';

        ROLLBACK TRANSACTION;
    ```

#### SAVEPOINT

Cria um ponto de retorno dentro de uma transação. Podemos voltar ao SAVEPOINT sem cancelar toda a transação.

```
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
```

### ACID

Uma transação confiável possui quatro propriedades fundamentais.

- **A** → Atomicidade -  Tudo ou nada;
- **C** → Consistência - A transação deve manter o banco obedecendo às regras;
- **I** → Isolamento - Quando várias transações acontecem ao mesmo tempo, uma não deve interferir incorretamente na outra;
- **D** → Durabilidade - Alteração confirmada permanece;
