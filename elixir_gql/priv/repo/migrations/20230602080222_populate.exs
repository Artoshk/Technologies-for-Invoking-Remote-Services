defmodule ElixirGql.Repo.Migrations.Populate do
  use Ecto.Migration

  def up do
    execute_usuarios()
    execute_musicas()
    execute_playlists()
    execute_playlists_musicas()
  end

  def down do
    # Define the rollback steps if needed
  end

  defp execute_usuarios do
    execute("INSERT INTO public.usuarios (id, nome, idade, inserted_at, updated_at)
             VALUES (1, 'User 1', 25, current_timestamp, current_timestamp)")

    execute("INSERT INTO public.usuarios (id, nome, idade, inserted_at, updated_at)
             VALUES (2, 'User 2', 30, current_timestamp, current_timestamp)")
  end

  defp execute_musicas do
    execute("INSERT INTO public.musicas (id, nome, artista, inserted_at, updated_at)
             VALUES (1, 'Song 1', 'Artist 1', current_timestamp, current_timestamp)")

    execute("INSERT INTO public.musicas (id, nome, artista, inserted_at, updated_at)
             VALUES (2, 'Song 2', 'Artist 2', current_timestamp, current_timestamp)")

    execute("INSERT INTO public.musicas (id, nome, artista, inserted_at, updated_at)
             VALUES (3, 'Song 3', 'Artist 3', current_timestamp, current_timestamp)")
  end

  defp execute_playlists do
    execute("INSERT INTO public.playlists (id, nome, usuario_id, inserted_at, updated_at)
             VALUES (1, 'Playlist 1', 1, current_timestamp, current_timestamp)")

    execute("INSERT INTO public.playlists (id, nome, usuario_id, inserted_at, updated_at)
             VALUES (2, 'Playlist 2', 1, current_timestamp, current_timestamp)")

    execute("INSERT INTO public.playlists (id, nome, usuario_id, inserted_at, updated_at)
             VALUES (3, 'Playlist 3', 2, current_timestamp, current_timestamp)")
  end

  defp execute_playlists_musicas do
    execute("INSERT INTO public.playlists_musicas (id, playlist_id, musica_id, inserted_at, updated_at)
             VALUES (1, 1, 1, current_timestamp, current_timestamp)")

    execute("INSERT INTO public.playlists_musicas (id, playlist_id, musica_id, inserted_at, updated_at)
             VALUES (2, 1, 2, current_timestamp, current_timestamp)")

    execute("INSERT INTO public.playlists_musicas (id, playlist_id, musica_id, inserted_at, updated_at)
             VALUES (3, 2, 1, current_timestamp, current_timestamp)")

    execute("INSERT INTO public.playlists_musicas (id, playlist_id, musica_id, inserted_at, updated_at)
             VALUES (4, 2, 3, current_timestamp, current_timestamp)")

    execute("INSERT INTO public.playlists_musicas (id, playlist_id, musica_id, inserted_at, updated_at)
             VALUES (5, 3, 2, current_timestamp, current_timestamp)")

    execute("INSERT INTO public.playlists_musicas (id, playlist_id, musica_id, inserted_at, updated_at)
             VALUES (6, 3, 3, current_timestamp, current_timestamp)")
  end
end
