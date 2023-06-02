-- Insert data into the usuarios table
INSERT INTO public.usuarios (id, nome, idade, inserted_at, updated_at)
VALUES
    (1, 'User 1', 25, current_timestamp, current_timestamp),
    (2, 'User 2', 30, current_timestamp, current_timestamp);

-- Insert data into the musicas table
INSERT INTO public.musicas (id, nome, artista, inserted_at, updated_at)
VALUES
    (1, 'Song 1', 'Artist 1', current_timestamp, current_timestamp),
    (2, 'Song 2', 'Artist 2', current_timestamp, current_timestamp),
    (3, 'Song 3', 'Artist 3', current_timestamp, current_timestamp);

-- Insert data into the playlists table
INSERT INTO public.playlists (id, nome, usuario_id, inserted_at, updated_at)
VALUES
    (1, 'Playlist 1', 1, current_timestamp, current_timestamp),
    (2, 'Playlist 2', 1, current_timestamp, current_timestamp),
    (3, 'Playlist 3', 2, current_timestamp, current_timestamp);

-- Insert data into the playlists_musicas table
INSERT INTO public.playlists_musicas (id, playlist_id, musica_id, inserted_at, updated_at)
VALUES
    (1, 1, 1, current_timestamp, current_timestamp),
    (2, 1, 2, current_timestamp, current_timestamp),
    (3, 2, 1, current_timestamp, current_timestamp),
    (4, 2, 3, current_timestamp, current_timestamp),
    (5, 3, 2, current_timestamp, current_timestamp),
    (6, 3, 3, current_timestamp, current_timestamp);


