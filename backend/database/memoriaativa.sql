-- Auxílio de IA (Gemini)

-- Seleciona o banco de dados
USE memoriaativa_db;

-- 1. Tabela 'user'
CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    nivel_memoria INT DEFAULT 0,
    genero ENUM('Masculino', 'Feminino', 'Outro', 'Prefiro não dizer'),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB; -- Garante que o motor seja InnoDB

-- 2. Tabela 'guia'
CREATE TABLE IF NOT EXISTS guia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    conteudo LONGTEXT,
    categoria ENUM('Memoria', 'Atencao', 'Concentracao', 'Funcoes executivas', 'Velocidade', 'Logica', 'Curiosidades') NOT NULL,
    ordem INT
) ENGINE=InnoDB;

-- 3. Tabela 'jogos'
CREATE TABLE IF NOT EXISTS jogos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    categoria VARCHAR(100),
    nivel_dificuldade ENUM('Facil', 'Medio', 'Dificil')
) ENGINE=InnoDB;

-- 4. Tabela 'jogos_resultados' (Depende de 'user' e 'jogos')
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

-- 5. Tabela 'diario' (Depende de 'user')
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

-- 6. Tabela 'questionario' (Depende de 'user')
CREATE TABLE IF NOT EXISTS questionario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    pergunta VARCHAR(500) NOT NULL,
    resposta TEXT,
    respondido_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_questionario_user
        FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 7. Tabela 'calendario' (Depende de 'user')
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

-- 8. Tabela 'alarmes' (Depende de 'user')
-- NOTA: Removido 'dias_ativos' daqui, será gerenciado por 'alarme_dias'
CREATE TABLE IF NOT EXISTS alarmes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    horario TIME NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_alarmes_user
        FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 9. Tabela 'dias_da_semana' (Deve ser criada antes de 'alarme_dias')
CREATE TABLE IF NOT EXISTS dias_da_semana (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_dia VARCHAR(20) UNIQUE NOT NULL
) ENGINE=InnoDB;

-- Inserir os dias da semana (execute apenas uma vez, APÓS criar a tabela)
INSERT IGNORE INTO dias_da_semana (nome_dia) VALUES
('Domingo'), ('Segunda-feira'), ('Terça-feira'), ('Quarta-feira'),
('Quinta-feira'), ('Sexta-feira'), ('Sábado');

-- 10. Tabela 'alarme_dias' (Depende de 'alarmes' e 'dias_da_semana')
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