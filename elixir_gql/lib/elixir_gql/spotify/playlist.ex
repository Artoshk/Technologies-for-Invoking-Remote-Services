defmodule ElixirGql.Spotify.Playlist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "playlists" do
    field :nome, :string
    belongs_to :usuarios, ElixirGql.Spotify.Usuario, foreign_key: :usuario_id
    many_to_many :musicas, ElixirGql.Spotify.Musica, join_through: "playlists_musicas"

    timestamps()
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [:nome])
    |> validate_required([:nome])
  end
end
