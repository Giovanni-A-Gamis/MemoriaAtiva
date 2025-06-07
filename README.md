# MemoriaAtiva - Backend
TCC do curso de desenvolvimento de sistemas pela Etec Bento Quirino

# MemóriaAtiva - Backend da API

[![Node.js](https://img.shields.io/badge/Node.js-18.x-green?logo=node.js)](https://nodejs.org/)
[![Express.js](https://img.shields.io/badge/Express.js-4.x-blue?logo=express)](https://expressjs.com/)
[![MySQL](https://img.shields.io/badge/MySQL-8.x-orange?logo=mysql)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-ISC-blue.svg)](https://opensource.org/licenses/ISC)

Este repositório contém o código-fonte do backend da aplicação MemóriaAtiva, uma API RESTful desenvolvida com Node.js e Express.js, utilizando MySQL como banco de dados. O objetivo é fornecer as funcionalidades essenciais para o aplicativo MemóriaAtiva, focado em auxiliar pessoas com Alzheimer e seus cuidadores.

## 🚀 Funcionalidades Principais

* **Autenticação de Usuários:** Cadastro e Login de usuários, com autenticação via JWT.
* **Gestão de Usuários:** CRUD (Criação, Leitura, Atualização, Deleção) de perfis de usuários.
* **Gestão de Guias:** Seções de conteúdo informativo sobre Alzheimer (dicas, cuidados, etc.).
* **Gestão de Jogos:** Definição e registro de jogos para estimular a memória.
* **Registro de Resultados de Jogos:** Acompanhamento do progresso dos usuários nos jogos (XP, etc.).
* **Diário Pessoal:** Funcionalidade para registro de anotações diárias.
* **Questionários:** Registro de perguntas e respostas relevantes.
* **Calendário de Eventos:** Gerenciamento de compromissos e lembretes.
* **Alarmes Personalizados:** Configuração de alarmes recorrentes para tarefas diárias.

## 💻 Tecnologias Utilizadas

* **Node.js:** Ambiente de execução JavaScript.
* **Express.js:** Framework web para Node.js.
* **MySQL:** Sistema de gerenciamento de banco de dados relacional.
* **`mysql2`:** Driver MySQL para Node.js com suporte a Promises.
* **`bcryptjs`:** Biblioteca para hashing de senhas.
* **`jsonwebtoken`:** Para geração e verificação de JSON Web Tokens (JWT).
* **`dotenv`:** Para gerenciamento de variáveis de ambiente.
* **`nodemon` (dev):** Ferramenta para desenvolvimento que reinicia o servidor automaticamente.

## 📁 Estrutura do Projeto

memoriaativa-backend/
├── src/
│   ├── config/             # Configurações do banco de dados
│   │   └── database.js
│   ├── models/             # Definição dos modelos (interação com o DB)
│   │   ├── User.js
│   │   └── Guia.js
│   │   └── ... (outros modelos)
│   ├── controllers/        # Lógica de negócio da API
│   │   ├── userController.js
│   │   └── guiaController.js
│   │   └── ... (outros controllers)
│   ├── routes/             # Definição das rotas da API
│   │   ├── userRoutes.js
│   │   ├── guiaRoutes.js
│   │   │── router.js       # Roteador principal
│   │   └── ... (outras rotas)
│   ├── app.js              # Configuração principal do Express
│   └── server.js           # Ponto de entrada da aplicação
├── .env.example            # Exemplo do arquivo de variáveis de ambiente
├── .gitignore              # Arquivos e pastas a serem ignorados pelo Git
├── package.json            # Dependências e scripts do projeto
├── README.md               # Este arquivo!


## ⚙️ Configuração e Instalação

Siga os passos abaixo para configurar e rodar o projeto localmente.

### Pré-requisitos

* [Node.js](https://nodejs.org/en/download/) (versão 18 ou superior recomendada)
* [npm](https://www.npmjs.com/get-npm) (gerenciador de pacotes do Node.js)
* [MySQL Server](https://dev.mysql.com/downloads/mysql/) (versão 8 ou superior recomendada)
* Uma ferramenta para testar APIs (ex: [Postman](https://www.postman.com/downloads/) ou [Insomnia](https://insomnia.rest/download))

### 1. Clonar o Repositório

git clone [https://github.com/](https://github.com/)<seu-usuario>/memoriaativa-backend.git
cd memoriaativa-backend

2. Instalar Dependências


npm install

3. Configurar Variáveis de Ambiente

Crie um arquivo .env na raiz do projeto, baseado no .env.example:
Bash

cp .env.example .env

Edite o arquivo .env com suas credenciais do MySQL e a chave secreta JWT:
Snippet de código

# Variáveis do Servidor
PORT=3000

# Variáveis do Banco de Dados MySQL
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=sua_senha_do_mysql_aqui
DB_NAME=memoriaativa_db

# Chave Secreta para JWT (JSON Web Tokens)
JWT_SECRET=sua_chave_secreta_para_jwt_aqui # Use uma string longa e aleatória!

Importante: Substitua sua_senha_do_mysql_aqui e sua_chave_secreta_para_jwt_aqui por valores reais. A chave JWT deve ser complexa e única.
4. Configurar o Banco de Dados MySQL

Certifique-se de que seu servidor MySQL está rodando. Em seguida, execute o script SQL para criar o banco de dados e as tabelas:

    Acesse seu cliente MySQL (MySQL Workbench, phpMyAdmin ou terminal).

    Execute os seguintes comandos SQL na ordem:
    SQL

    -- 1. Cria o banco de dados
    CREATE DATABASE IF NOT EXISTS memoriaativa_db;

    -- 2. Seleciona o banco de dados
    USE memoriaativa_db;

    -- 3. Cria a tabela 'user'
    CREATE TABLE IF NOT EXISTS user (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nome VARCHAR(255) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        senha_hash VARCHAR(255) NOT NULL,
        data_nascimento DATE,
        nivel_memoria INT DEFAULT 0,
        genero ENUM('Masculino', 'Feminino', 'Outro', 'Prefiro não dizer'),
        criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;

    -- 4. Cria a tabela 'guia'
    CREATE TABLE IF NOT EXISTS guia (
        id INT AUTO_INCREMENT PRIMARY KEY,
        titulo VARCHAR(255) NOT NULL,
        conteudo LONGTEXT,
        categoria ENUM('Geral', 'Saude', 'Alimentacao', 'Exercicios', 'Tecnologia', 'Causas', 'Prevencao') NOT NULL,
        ordem INT
    ) ENGINE=InnoDB;

    -- 5. Cria a tabela 'jogos'
    CREATE TABLE IF NOT EXISTS jogos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nome VARCHAR(255) NOT NULL,
        descricao TEXT,
        categoria VARCHAR(100),
        nivel_dificuldade ENUM('Facil', 'Medio', 'Dificil')
    ) ENGINE=InnoDB;

    -- 6. Cria a tabela 'jogos_resultados'
    CREATE TABLE IF NOT EXISTS jogos_resultados (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        jogo_id INT NOT NULL,
        xp INT NOT NULL,
        data_jogada DATETIME DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_jogoresultado_user
            FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
        CONSTRAINT fk_jogoresultado_jogos
            FOREIGN KEY (jogo_id) REFERENCES jogos(id) ON DELETE CASCADE
    ) ENGINE=InnoDB;

    -- 7. Cria a tabela 'diario'
    CREATE TABLE IF NOT EXISTS diario (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        titulo VARCHAR(255),
        conteudo LONGTEXT,
        data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
        editado_em DATETIME ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT fk_diario_user
            FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
    ) ENGINE=InnoDB;

    -- 8. Cria a tabela 'questionario'
    CREATE TABLE IF NOT EXISTS questionario (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        pergunta VARCHAR(500) NOT NULL,
        resposta TEXT,
        respondido_em DATETIME DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_questionario_user
            FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
    ) ENGINE=InnoDB;

    -- 9. Cria a tabela 'calendario'
    CREATE TABLE IF NOT EXISTS calendario (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        titulo VARCHAR(255) NOT NULL,
        descricao LONGTEXT,
        data_evento DATE NOT NULL,
        hora_evento TIME,
        repetir BOOLEAN DEFAULT FALSE,
        notificar BOOLEAN DEFAULT FALSE,
        CONSTRAINT fk_calendario_user
            FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
    ) ENGINE=InnoDB;

    -- 10. Cria a tabela 'alarmes' (sem dias_ativos)
    CREATE TABLE IF NOT EXISTS alarmes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        titulo VARCHAR(255) NOT NULL,
        horario TIME NOT NULL,
        ativo BOOLEAN DEFAULT TRUE,
        CONSTRAINT fk_alarmes_user
            FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
    ) ENGINE=InnoDB;

    -- 11. Cria a tabela 'dias_da_semana'
    CREATE TABLE IF NOT EXISTS dias_da_semana (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nome_dia VARCHAR(20) UNIQUE NOT NULL
    ) ENGINE=InnoDB;

    -- 12. Insere os dias da semana (execute apenas uma vez)
    INSERT IGNORE INTO dias_da_semana (nome_dia) VALUES
    ('Domingo'), ('Segunda-feira'), ('Terça-feira'), ('Quarta-feira'),
    ('Quinta-feira'), ('Sexta-feira'), ('Sábado');

    -- 13. Cria a tabela 'alarme_dias' (tabela de junção N:N)
    CREATE TABLE IF NOT EXISTS alarme_dias (
        alarme_id INT NOT NULL,
        dia_semana_id INT NOT NULL,
        PRIMARY KEY (alarme_id, dia_semana_id),

        CONSTRAINT fk_alarme_dias_alarme_id
            FOREIGN KEY (alarme_id)
            REFERENCES alarmes(id)
            ON DELETE CASCADE,

        CONSTRAINT fk_alarme_dias_dia_semana_id
            FOREIGN KEY (dia_semana_id)
            REFERENCES dias_da_semana(id)
            ON DELETE CASCADE
    ) ENGINE=InnoDB;

5. Rodar a Aplicação

Para iniciar o servidor em modo de desenvolvimento (com reinício automático):
Bash

npm run dev

Para iniciar o servidor em modo de produção:
Bash

npm start

O servidor estará rodando em http://localhost:3000 (ou na porta definida no seu .env).
🗺️ Endpoints da API

A URL base para todos os endpoints é http://localhost:3000/api.
Exemplo de Endpoints (Módulos users e guias)

Usuários:

    POST /api/users/register - Registrar um novo usuário.
    POST /api/users/login - Autenticar usuário e obter JWT.
    GET /api/users/:id - Obter detalhes de um usuário por ID.
    ... (Outros endpoints de usuários, conforme forem implementados)

Guias:

    POST /api/guias - Criar uma nova guia.
    GET /api/guias - Listar todas as guias.
    GET /api/guias/:id - Obter detalhes de uma guia por ID.
    PUT /api/guias/:id - Atualizar uma guia por ID.
    DELETE /api/guias/:id - Deletar uma guia por ID.
    ... (Outros endpoints, conforme forem implementados)
