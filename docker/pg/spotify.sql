-- Criação da tabela Usuario
CREATE TABLE Usuario (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(100),
    Idade INTEGER
);

-- Criação da tabela Playlist
CREATE TABLE Playlist (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(100),
    Usuario_ID INTEGER REFERENCES Usuario(ID)
);

-- Criação da tabela Musica
CREATE TABLE Musica (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(100),
    Artista VARCHAR(100)
);

-- Criação da tabela Playlist_Musica (tabela de associação)
CREATE TABLE Playlist_Musica (
    ID SERIAL PRIMARY KEY,
    Playlist_ID INTEGER REFERENCES Playlist(ID),
    Musica_ID INTEGER REFERENCES Musica(ID)
);

-- Inserir dados na tabela Usuario
INSERT INTO Usuario (Nome, Idade) VALUES
    ('Joao', 25),
    ('Maria', 30),
    ('Pedro', 28),
    ('Ana', 35);

-- Inserir dados na tabela Playlist
INSERT INTO Playlist (Nome, Usuario_ID) VALUES
    ('Playlist 1', 1),
    ('Playlist 2', 1),
    ('Playlist 3', 2),
    ('Playlist 4', 3);

-- Inserir dados na tabela Musica
INSERT INTO Musica (Nome, Artista) VALUES
    ('Musica 1', 'Artista 1'),
    ('Musica 2', 'Artista 2'),
    ('Musica 3', 'Artista 3'),
    ('Musica 4', 'Artista 4');

-- Inserir dados na tabela Playlist_Musica
INSERT INTO Playlist_Musica (Playlist_ID, Musica_ID) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 2),
    (2, 3),
    (2, 4),
    (2, 2),
    (3, 4),
    (3, 1),
    (3, 2),
    (4, 1),
    (4, 2);
