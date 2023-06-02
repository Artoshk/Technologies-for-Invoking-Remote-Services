defmodule ElixirGqlWeb.Schema.Schema do
  use Absinthe.Schema

  query do
    @desc "Get all usuarios"
    field :usuarios, list_of(:usuario) do
      resolve &ElixirGqlWeb.Resolvers.Spotify.all_usuarios/3
    end

    @desc "Get a usuario by id"
    field :usuario, :usuario do
      arg :id, non_null(:id)
      resolve &ElixirGqlWeb.Resolvers.Spotify.get_usuario/3
    end

    @desc "Get all musicas"
    field :musicas, list_of(:musica) do
      resolve &ElixirGqlWeb.Resolvers.Spotify.all_musicas/3
    end

    @desc "Get a musica by id"
    field :musica, :musica do
      arg :id, non_null(:id)
      resolve &ElixirGqlWeb.Resolvers.Spotify.get_musica/3
    end

    @desc "Get all playlists"
    field :playlists, list_of(:playlist) do
      resolve &ElixirGqlWeb.Resolvers.Spotify.all_playlists/3
    end

    @desc "Get a playlist by id"
    field :playlist, :playlist do
      arg :id, non_null(:id)
      resolve &ElixirGqlWeb.Resolvers.Spotify.get_playlist/3
    end
  end

  object :usuario do
    field :id, :id
    field :nome, :string
    field :idade, :integer
    field :playlists, list_of(:playlist)
  end

  object :musica do
    field :id, :id
    field :nome, :string
    field :artista, :string
    field :playlists, list_of(:playlist)
  end

  object :playlist do
    field :id, :id
    field :nome, :string
    field :usuarios, :usuario
    field :musicas, list_of(:musica)
  end

end
