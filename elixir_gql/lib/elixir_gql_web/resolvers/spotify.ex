defmodule ElixirGqlWeb.Resolvers.Spotify do
  alias ElixirGql.Spotify

  def all_usuarios(_, _, _) do
    {:ok, Spotify.list_usuarios()}
  end

  def get_usuario(_, %{id: id}, _) do
    {:ok, Spotify.get_usuario!(id)}
  end

  def all_musicas(_, _, _) do
    {:ok, Spotify.list_musicas()}
  end

  def get_musica(_, %{id: id}, _) do
    {:ok, Spotify.get_musica!(id)}
  end

  def all_playlists(_, _, _) do
    {:ok, Spotify.list_playlists()}
  end

  def get_playlist(_, %{id: id}, _) do
    {:ok, Spotify.get_playlist!(id)}
  end

end
