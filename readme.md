# Comandos SQL

Repositório de consulta rápida de **comandos SQL** para alunos do **Curso Técnico em Informática**.
Este material tem como objetivo ajudar nos estudos e nas atividades práticas de Banco de Dados.

### - Banco de Dados

Um Banco de Dados (BD) é uma coleção organizada de informações que podem ser armazenadas, consultadas, alteradas e excluídas.

### - Sistema de Gerenciamento de Banco de Dados (SGBD)
É o software responsável por criar, armazenar, organizar, consultar, alterar e controlar os dados de um banco de dados.
Exemplos de SGBDs: 
- MySQL
- PostgreSQL
- Oracle Database
- Microsoft SQL Server
- MariaDB
- SQLite

### - O que é SQL?
SQL (Structured Query Language) __Linguagem de Consulta Estruturada__ é uma linguagem utilizada para trabalhar com bancos de dados relacionais.
- DDL - Data Definition Language: É utilizada para definir e modificar a estrutura do banco de dados. Exemplo de comandos (CREATE, ALTER, DROP, TRUNCATE);
- DQL - Data Query Language: É utilizada para consultar dados. Exemplo de comando (SELECT);
- DML - Data Manipulation Language: É utilizada para manipular os dados armazenados nas tabelas. Exemplo de comandos ( INSERT, UPDATE, DELETE)
- DCL - Data Control Language: É utilizada para controlar permissões e acessos ao banco. Exemplo de comandos (GRANT, REVOKE)
- TCL - Transaction Control Language: É utilizada para controlar transações. Exemplo de comandos (COMMIT, ROLLBACK, SAVEPOINT)

### - Banco de Dados Relacional
Um Banco de Dados Relacional organiza os dados principalmente em tabelas.
As tabelas podem se relacionar umas com as outras. 

### - Glossario: 
- **Tabela:** Uma tabela organiza os dados em linhas e colunas.
- **Coluna:** Representa uma característica do dado.
- **Linha / Registro:** Representa um registro completo.
- **Chave Primária — PRIMARY KEY:** A (PK) identifica de forma única cada registro de uma tabela. Características: Identifica o registro./ Deve ser única. / Não deve ser NULL
- **Chave Estrangeira — FOREIGN KEY:** A (FK) é utilizada para criar um relacionamento entre tabelas.

### - Integridade dos dados

O banco de dados possui mecanismos para ajudar a manter os dados corretos e consistentes.

- *NOT NULL:* Campo obrigatório:
EX:. nome VARCHAR(100) NOT NULL
- *UNIQUE:* Impede valores duplicados:
EX:. email VARCHAR(100) UNIQUE
- *PRIMARY KEY:* Identifica um registro:
EX:. id INT PRIMARY KEY
- *FOREIGN KEY:* Garante relacionamento entre tabelas:
EX:. FOREIGN KEY (curso_id) REFERENCES cursos(id)
- *CHECK:* Cria uma condição:
EX:. idade INT CHECK (idade >= 0)

### CRUD: 
CRUD representa as quatro operações básicas de manipulação de dados
- **C** → Create
- **R** → Read
- **U** → Update
- **D** → Delete