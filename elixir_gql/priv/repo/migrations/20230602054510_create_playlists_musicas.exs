defmodule ElixirGql.Repo.Migrations.CreatePlaylistsMusicas do
  use Ecto.Migration

  def change do
    create table(:playlists_musicas) do
      add :playlist_id, references(:playlists, on_delete: :nothing)
      add :musica_id, references(:musicas, on_delete: :nothing)

      timestamps()
    end

    create index(:playlists_musicas, [:playlist_id])
    create index(:playlists_musicas, [:musica_id])
  end
end
