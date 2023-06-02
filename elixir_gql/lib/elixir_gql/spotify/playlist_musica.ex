defmodule ElixirGql.Spotify.PlaylistMusica do
  use Ecto.Schema
  import Ecto.Changeset

  schema "playlists_musicas" do

    field :playlist_id, :id
    field :musica_id, :id

    timestamps()
  end

  @doc false
  def changeset(playlist_musica, attrs) do
    playlist_musica
    |> cast(attrs, [])
    |> validate_required([])
  end
end
