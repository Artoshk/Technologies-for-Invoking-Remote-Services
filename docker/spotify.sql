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
    Artista VARCHAR(100),
    Playlist_ID INTEGER REFERENCES Playlist(ID)
);

-- Inserção de usuarios
INSERT INTO Usuario (Nome, Idade) VALUES
    ('Usuario 1', 25),
    ('Usuario 2', 30),
    ('Usuario 3', 40),
    ('Usuario 4', 22),
    ('Usuario 5', 28);

-- Inserção de playlists do Usuario 1
INSERT INTO Playlist (Nome, Usuario_ID) VALUES
    ('Playlist 1 do Usuario 1', 1),
    ('Playlist 2 do Usuario 1', 1);

-- Inserção de musicas na Playlist 1 do Usuario 1
INSERT INTO Musica (Nome, Artista, Playlist_ID) VALUES
    ('Musica 1', 'Artista 1', 1),
    ('Musica 2', 'Artista 2', 1),
    ('Musica 3', 'Artista 3', 1);

-- Inserção de musicas na Playlist 2 do Usuario 1
INSERT INTO Musica (Nome, Artista, Playlist_ID) VALUES
    ('Musica 4', 'Artista 4', 2),
    ('Musica 5', 'Artista 5', 2);

-- Inserção de playlists do Usuario 2
INSERT INTO Playlist (Nome, Usuario_ID) VALUES
    ('Playlist 1 do Usuario 2', 2);

-- Inserção de musicas na Playlist 1 do Usuario 2
INSERT INTO Musica (Nome, Artista, Playlist_ID) VALUES
    ('Musica 6', 'Artista 6', 3);

-- Inserção de playlists do Usuario 3
INSERT INTO Playlist (Nome, Usuario_ID) VALUES
    ('Playlist 1 do Usuario 3', 3),
    ('Playlist 2 do Usuario 3', 3),
    ('Playlist 3 do Usuario 3', 3);

-- Inserção de musicas na Playlist 1 do Usuario 3
INSERT INTO Musica (Nome, Artista, Playlist_ID) VALUES
    ('Musica 7', 'Artista 7', 4),
    ('Musica 8', 'Artista 8', 4),
    ('Musica 9', 'Artista 9', 4),
    ('Musica 10', 'Artista 10', 4);

-- Inserção de musicas na Playlist 2 do Usuario 3
INSERT INTO Musica (Nome, Artista, Playlist_ID) VALUES
    ('Musica 11', 'Artista 11', 5),
    ('Musica 12', 'Artista 12', 5);

-- Inserção de musicas na Playlist 3 do Usuario 3
INSERT INTO Musica (Nome, Artista, Playlist_ID) VALUES
    ('Musica 13', 'Artista 13', 6);

-- Inserção de playlists do Usuario 4
INSERT INTO Playlist (Nome, Usuario_ID) VALUES
    ('Playlist 1 do Usuario 4', 4);

-- Inserção de musicas na Playlist 1 do Usuario 4
INSERT INTO Musica (Nome, Artista, Playlist_ID) VALUES
    ('Musica 14', 'Artista 14', 7);

-- Inserção de playlists do Usuario 5
INSERT INTO Playlist (Nome, Usuario_ID) VALUES
    ('Playlist 1 do Usuario 5', 5);

-- Inserção de musicas na Playlist 1 do Usuario 5
INSERT INTO Musica (Nome, Artista, Playlist_ID) VALUES
    ('Musica 15', 'Artista 15', 8);
