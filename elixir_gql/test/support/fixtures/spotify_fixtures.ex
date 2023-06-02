defmodule ElixirGql.SpotifyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirGql.Spotify` context.
  """

  @doc """
  Generate a usuario.
  """
  def usuario_fixture(attrs \\ %{}) do
    {:ok, usuario} =
      attrs
      |> Enum.into(%{
        idade: 42,
        nome: "some nome"
      })
      |> ElixirGql.Spotify.create_usuario()

    usuario
  end

  @doc """
  Generate a musica.
  """
  def musica_fixture(attrs \\ %{}) do
    {:ok, musica} =
      attrs
      |> Enum.into(%{
        artista: "some artista",
        nome: "some nome"
      })
      |> ElixirGql.Spotify.create_musica()

    musica
  end

  @doc """
  Generate a playlist.
  """
  def playlist_fixture(attrs \\ %{}) do
    {:ok, playlist} =
      attrs
      |> Enum.into(%{
        nome: "some nome"
      })
      |> ElixirGql.Spotify.create_playlist()

    playlist
  end

  @doc """
  Generate a playlist_musica.
  """
  def playlist_musica_fixture(attrs \\ %{}) do
    {:ok, playlist_musica} =
      attrs
      |> Enum.into(%{

      })
      |> ElixirGql.Spotify.create_playlist_musica()

    playlist_musica
  end
end
