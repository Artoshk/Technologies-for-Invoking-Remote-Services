defmodule ElixirGql.Spotify.Musica do
  use Ecto.Schema
  import Ecto.Changeset

  schema "musicas" do
    field :artista, :string
    field :nome, :string
    many_to_many :playlists, ElixirGql.Spotify.Playlist, join_through: "playlists_musicas"

    timestamps()
  end

  @doc false
  def changeset(musica, attrs) do
    musica
    |> cast(attrs, [:nome, :artista])
    |> validate_required([:nome, :artista])
  end
end
