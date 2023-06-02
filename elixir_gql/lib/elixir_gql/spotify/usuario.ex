defmodule ElixirGql.Spotify.Usuario do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usuarios" do
    field :idade, :integer
    field :nome, :string
    has_many :playlists, ElixirGql.Spotify.Playlist, foreign_key: :usuario_id

    timestamps()
  end

  @doc false
  def changeset(usuario, attrs) do
    usuario
    |> cast(attrs, [:nome, :idade])
    |> validate_required([:nome, :idade])
  end
end
