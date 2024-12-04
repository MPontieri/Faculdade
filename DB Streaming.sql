CREATE DATABASE AppMusica;
USE AppMusica;


-- os ID foram gerados com numeros para faciliatar a execução do trabalho, por esse motivo os ID não foram gerados como AUTO_INCREMENT
CREATE TABLE Usuarios (
    id INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    idade DATE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    Assinatura BOOLEAN DEFAULT FALSE
);

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    duracao TIME NOT NULL,
    descricao TEXT,
    privacidade BOOLEAN DEFAULT TRUE,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE Musicas (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    duracao TIME NOT NULL,
    lancamento DATE NOT NULL,
    id_genero INT,
    id_album INT,
    id_gravadora INT,
    FOREIGN KEY (id_genero) REFERENCES Generos(id),
    FOREIGN KEY (id_album) REFERENCES Albuns(id),
    FOREIGN KEY (id_gravadora) REFERENCES Gravadoras(id)
);

CREATE TABLE Albuns (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    duracao TIME NOT NULL,
    lancamento DATE NOT NULL,
    capa LONGBLOB,
    id_genero INT,
    id_artista INT,
    FOREIGN KEY (id_genero) REFERENCES Generos(id),
    FOREIGN KEY (id_artista) REFERENCES Artistas(id)
);

CREATE TABLE Artistas (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    etnia VARCHAR(100),
    biografia LONGTEXT,
    id_genero INT,
    id_gravadora INT,
    FOREIGN KEY (id_genero) REFERENCES Generos(id),
    FOREIGN KEY (id_gravadora) REFERENCES Gravadoras(id)
);

CREATE TABLE Gravadoras (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    pais_origem VARCHAR(100),
    descricao TEXT,
    data_criacao DATE NOT NULL
);

CREATE TABLE Generos (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT
);

CREATE TABLE Avaliacoes (
    id INT PRIMARY KEY,
    comentario TEXT,
    nota DECIMAL(2,1) NOT NULL,
    id_artista INT,
    id_musica INT,
    id_album INT,
    id_playlist INT,
    FOREIGN KEY (id_artista) REFERENCES Artistas(id),
    FOREIGN KEY (id_musica) REFERENCES Musicas(id),
    FOREIGN KEY (id_album) REFERENCES Albuns(id),
    FOREIGN KEY (id_playlist) REFERENCES Playlists(id)
);

CREATE TABLE Historicos (
    id INT PRIMARY KEY,
    data_reproducao DATE NOT NULL,
    id_usuario INT,
    id_musica INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    FOREIGN KEY (id_musica) REFERENCES Musicas(id)
);

CREATE TABLE Assinaturas (
    id INT PRIMARY KEY,
    preco DECIMAL(10,2) NOT NULL,
    tipo_assinatura VARCHAR(45) NOT NULL,
    descricao_assinatura LONGTEXT,
    duracao_assinatura TIME
);

-- Inserção de Dados

INSERT INTO Usuarios (id, email, idade, senha, Assinatura)
VALUES 
(1,'ana.silva@gmail.com', '2002-05-10', 'senha123', TRUE),
(2,'joao.pereira@yahoo.com', '1998-11-25', 'joao2024', FALSE),
(3,'mariana.costa@hotmail.com', '2000-03-15', 'mariana2024', TRUE),
(4,'pedro.almeida@outlook.com', '1995-07-30', 'almeida99', FALSE),
(5,'lucas.santos@gmail.com', '1999-01-20', 'lucas2023', TRUE),
(6,'juliana.oliveira@yahoo.com', '2001-09-05', 'ju2024', FALSE),
(7,'rafael.fernandes@icloud.com', '2003-12-01', 'rafa2023', TRUE),
(8,'beatriz.moura@hotmail.com', '1997-06-12', 'bia2024', FALSE);


INSERT INTO Playlists (nome, duracao, descricao, privacidade, id_usuario)
VALUES 
('Anos 2000', '02:45:30', 'As melhores músicas dos anos 2000.', TRUE, 1),
('MPB', '01:20:15', 'Clássicos e novos sucessos da música popular brasileira.', TRUE, 2),
('POP', '03:05:50', 'Hits do Pop internacional e nacional.', TRUE, 3),
('Rap', '02:10:00', 'Rap nacional e internacional para todos os gostos.', TRUE, 4),
('Rock', '02:30:45', 'Clássicos do rock e novos artistas.', TRUE, 5),
('Musicas Favoritas', '01:50:30', 'Uma playlist pessoal de músicas favoritas.', FALSE, 6),
('Relaxe', '02:00:00', 'Músicas calmas e relaxantes.', FALSE, 7);


INSERT INTO Musicas (id, nome, duracao, lancamento, id_genero, id_album, id_gravadora)
VALUES
(1, 'Construção', '00:06:00', '1971-11-01', 1, 1, 1),
(2, 'Geni e o Zepelim', '00:07:12', '1978-10-20', 1, 2, 1),
(3, 'Roda Viva', '00:05:25', '1968-03-15', 1, 3, 1),
(4, 'bad guy', '00:03:14', '2019-03-29', 2, 4, 2),
(5, 'everything i wanted', '00:04:05', '2019-11-13', 2, 5, 2),
(6, 'Happier Than Ever', '00:04:58', '2021-07-30', 2, 6, 2),
(7, 'Bohemian Rhapsody', '00:05:55', '1975-10-31', 3, 7, 3),
(8, 'We Will Rock You', '00:02:02', '1977-10-07', 3, 8, 3),
(9, 'Don’t Stop Me Now', '00:03:29', '1978-11-10', 3, 8, 3),
(10, 'Lose Yourself', '00:05:26', '2002-10-28', 4, 9, 4),
(11, 'The Real Slim Shady', '00:04:44', '2000-04-18', 4, 10, 4),
(12, 'Mockingbird', '00:04:11', '2004-04-25', 4, 11, 4),
(13, 'Levitating', '00:03:23', '2020-03-27', 2, 12, 5),
(14, 'Don’t Start Now', '00:03:03', '2019-10-31', 2, 12, 5),
(15, 'Physical', '00:03:13', '2020-01-31', 2, 12, 5);

INSERT INTO Albuns (id, nome, duracao, lancamento, capa, id_genero, id_artista)
VALUES
(1, 'Construção', '00:36:20', '1971-11-01', NULL, 1, 1),
(2, 'Ópera do Malandro', '00:42:15', '1978-10-20', NULL, 1, 1),
(3, 'Roda Viva', '00:40:00', '1968-03-15', NULL, 1, 1),
(4, 'When We All Fall Asleep, Where Do We Go?', '00:42:48', '2019-03-29', NULL, 2, 2),
(5, 'Singles', '00:16:20', '2019-11-13', NULL, 2, 2),
(6, 'Happier Than Ever', '00:56:50', '2021-07-30', NULL, 2, 2),
(7, 'A Night at the Opera', '00:43:08', '1975-11-21', NULL, 3, 3),
(8, 'News of the World', '00:39:00', '1977-10-28', NULL, 3, 3),
(9, '8 Mile Soundtrack', '01:10:24', '2002-10-28', NULL, 4, 4),
(10, 'The Marshall Mathers LP', '01:12:18', '2000-05-23', NULL, 4, 4),
(11, 'Encore', '01:16:50', '2004-11-12', NULL, 4, 4),
(12, 'Future Nostalgia', '00:37:00', '2020-03-27', NULL, 2, 5);

INSERT INTO Artistas (id, nome, etnia, biografia, id_genero, id_gravadora)
VALUES
(1, 'Chico Buarque', 'Caucasiano', 'Cantor, compositor, dramaturgo e escritor brasileiro. Considerado um dos maiores nomes da MPB.', 1, 1),
(2, 'Billie Eilish', 'Caucasiana', 'Cantora e compositora norte-americana, conhecida por sua voz única e músicas marcantes como "Bad Guy".', 2, 2),
(3, 'Queen', 'Mista', 'Banda britânica de rock formada em 1970. É uma das bandas mais influentes da história do rock.', 3, 3),
(4, 'Eminem', 'Caucasiano', 'Rapper, compositor e produtor norte-americano. Considerado um dos melhores rappers de todos os tempos.', 4, 4),
(5, 'Dua Lipa', 'Kosovar-Albanesa', 'Cantora e compositora britânica. Ganhou destaque com hits como "Don\'t Start Now".', 2, 5),
(6, 'Nirvana', 'Caucasiana', 'Banda norte-americana de rock/grunge formada em 1987, liderada por Kurt Cobain.', 3, 6);

INSERT INTO Gravadoras (id, nome, pais_origem, descricao, data_criacao)
VALUES
(1, 'Philips Records', 'Brasil', 'Gravadora que trabalhou com grandes nomes da música brasileira, incluindo Chico Buarque.', '1958-01-01'),
(2, 'Darkroom/Interscope Records', 'Estados Unidos', 'Gravadora norte-americana responsável pelos lançamentos de Billie Eilish.', '1990-01-01'),
(3, 'EMI Records', 'Reino Unido', 'Gravadora histórica do Reino Unido, conhecida por produzir os álbuns do Queen.', '1931-03-14'),
(4, 'Aftermath Entertainment', 'Estados Unidos', 'Gravadora de Eminem, especializada em rap e hip-hop.', '1996-03-22'),
(5, 'Warner Records', 'Reino Unido', 'Gravadora britânica responsável pelos álbuns de Dua Lipa.', '1958-03-19'),
(6, 'DGC Records', 'Estados Unidos', 'Gravadora americana que lançou os maiores sucessos do Nirvana.', '1990-01-01');

INSERT INTO Generos (id, nome, descricao)
VALUES
(1, 'MPB', 'Música Popular Brasileira, caracterizada por sua diversidade de ritmos e estilos.'),
(2, 'Pop', 'Gênero musical popular que combina melodias acessíveis e produção voltada para o público geral.'),
(3, 'Rock', 'Gênero musical caracterizado por guitarras elétricas, baixo e bateria. Inclui subgêneros como grunge e rock clássico.'),
(4, 'Rap', 'Gênero musical que mistura ritmo e poesia, destacando letras faladas ao som de batidas.'),
(5, 'Grunge', 'Subgênero do rock caracterizado por letras melancólicas e um som cru e distorcido.');

INSERT INTO Avaliacoes (id, comentario, nota, id_artista, id_musica, id_album, id_playlist)
VALUES
(1, 'A música tem uma letra incrível, Chico Buarque nunca decepciona.', 4.8, 1, 1, 1, 1),
(2, 'Adoro o álbum do Queen, uma obra-prima do rock.', 5.0, 3, 6, 2, 5),
(3, 'Billie Eilish sempre me impressiona com sua voz única.', 4.7, 2, 3, 3, 6),
(4, 'Nirvana é simplesmente perfeito, esse álbum marcou uma geração.', 5.0, 6, 10, 4, 3),
(5, 'Eminem manda muito bem nas rimas, playlist de Rap está ótima.', 4.9, 4, 12, 5, 4);

INSERT INTO Historicos (id, data_reproducao, id_usuario, id_musica)
VALUES
(1, '2024-11-10', 1, 1),
(2, '2024-11-11', 2, 3),
(3, '2024-11-12', 3, 6),
(4, '2024-11-12', 4, 10),
(5, '2024-11-13', 5, 12);

INSERT INTO Assinaturas (id, preco, tipo_assinatura, descricao_assinatura, duracao_assinatura)
VALUES
(1, 14.90, 'Mensal', 'Plano mensal de assinatura para acesso a todas as funcionalidades da plataforma.', '01:00:00'),
(2, 129.90, 'Anual', 'Plano anual de assinatura com 1 ano de acesso completo.', '12:00:00'),
(3, 14.90, 'Mensal', 'Plano mensal de assinatura para acesso a todas as funcionalidades da plataforma.', '01:00:00'),
(4, 129.90, 'Anual', 'Plano anual de assinatura com 1 ano de acesso completo.', '12:00:00'),
(5, 14.90, 'Mensal', 'Plano mensal de assinatura para acesso a todas as funcionalidades da plataforma.', '01:00:00');
