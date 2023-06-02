defmodule ElixirGql.Spotify do
  @moduledoc """
  The Spotify context.
  """

  import Ecto.Query, warn: false
  alias ElixirGql.Repo

  alias ElixirGql.Spotify.Usuario

  @doc """
  Returns the list of usuarios.

  ## Examples

      iex> list_usuarios()
      [%Usuario{}, ...]

  """
  def list_usuarios do
    Repo.all(Usuario)
    |> Repo.preload([playlists: [:musicas]])
  end

  @doc """
  Gets a single usuario.

  Raises `Ecto.NoResultsError` if the Usuario does not exist.

  ## Examples

      iex> get_usuario!(123)
      %Usuario{}

      iex> get_usuario!(456)
      ** (Ecto.NoResultsError)

  """
  def get_usuario!(id) do
    Repo.get!(Usuario, id)
    |> Repo.preload([playlists: [:musicas]])
  end

  @doc """
  Creates a usuario.

  ## Examples

      iex> create_usuario(%{field: value})
      {:ok, %Usuario{}}

      iex> create_usuario(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_usuario(attrs \\ %{}) do
    %Usuario{}
    |> Usuario.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a usuario.

  ## Examples

      iex> update_usuario(usuario, %{field: new_value})
      {:ok, %Usuario{}}

      iex> update_usuario(usuario, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_usuario(%Usuario{} = usuario, attrs) do
    usuario
    |> Usuario.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a usuario.

  ## Examples

      iex> delete_usuario(usuario)
      {:ok, %Usuario{}}

      iex> delete_usuario(usuario)
      {:error, %Ecto.Changeset{}}

  """
  def delete_usuario(%Usuario{} = usuario) do
    Repo.delete(usuario)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking usuario changes.

  ## Examples

      iex> change_usuario(usuario)
      %Ecto.Changeset{data: %Usuario{}}

  """
  def change_usuario(%Usuario{} = usuario, attrs \\ %{}) do
    Usuario.changeset(usuario, attrs)
  end

  alias ElixirGql.Spotify.Musica

  @doc """
  Returns the list of musicas.

  ## Examples

      iex> list_musicas()
      [%Musica{}, ...]

  """
  #preload the playlists
  def list_musicas do
    Repo.all(Musica)
    |> Repo.preload([playlists: [:usuarios]])
  end

  @doc """
  Gets a single musica.

  Raises `Ecto.NoResultsError` if the Musica does not exist.

  ## Examples

      iex> get_musica!(123)
      %Musica{}

      iex> get_musica!(456)
      ** (Ecto.NoResultsError)

  """
  def get_musica!(id) do
    Repo.get!(Musica, id)
    |> Repo.preload([playlists: [:usuarios]])
  end

  @doc """
  Creates a musica.

  ## Examples

      iex> create_musica(%{field: value})
      {:ok, %Musica{}}

      iex> create_musica(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_musica(attrs \\ %{}) do
    %Musica{}
    |> Musica.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a musica.

  ## Examples

      iex> update_musica(musica, %{field: new_value})
      {:ok, %Musica{}}

      iex> update_musica(musica, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_musica(%Musica{} = musica, attrs) do
    musica
    |> Musica.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a musica.

  ## Examples

      iex> delete_musica(musica)
      {:ok, %Musica{}}

      iex> delete_musica(musica)
      {:error, %Ecto.Changeset{}}

  """
  def delete_musica(%Musica{} = musica) do
    Repo.delete(musica)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking musica changes.

  ## Examples

      iex> change_musica(musica)
      %Ecto.Changeset{data: %Musica{}}

  """
  def change_musica(%Musica{} = musica, attrs \\ %{}) do
    Musica.changeset(musica, attrs)
  end

  alias ElixirGql.Spotify.Playlist

  @doc """
  Returns the list of playlists.

  ## Examples

      iex> list_playlists()
      [%Playlist{}, ...]

  """
  def list_playlists do
    Repo.all(Playlist)
    |> Repo.preload(:musicas)
    |> Repo.preload(:usuarios)
  end

  @doc """
  Gets a single playlist.

  Raises `Ecto.NoResultsError` if the Playlist does not exist.

  ## Examples

      iex> get_playlist!(123)
      %Playlist{}

      iex> get_playlist!(456)
      ** (Ecto.NoResultsError)

  """
  def get_playlist!(id) do
    Repo.get!(Playlist, id)
    |> Repo.preload(:musicas)
    |> Repo.preload(:usuarios)
  end

  @doc """
  Creates a playlist.

  ## Examples

      iex> create_playlist(%{field: value})
      {:ok, %Playlist{}}

      iex> create_playlist(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_playlist(attrs \\ %{}) do
    %Playlist{}
    |> Playlist.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a playlist.

  ## Examples

      iex> update_playlist(playlist, %{field: new_value})
      {:ok, %Playlist{}}

      iex> update_playlist(playlist, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_playlist(%Playlist{} = playlist, attrs) do
    playlist
    |> Playlist.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a playlist.

  ## Examples

      iex> delete_playlist(playlist)
      {:ok, %Playlist{}}

      iex> delete_playlist(playlist)
      {:error, %Ecto.Changeset{}}

  """
  def delete_playlist(%Playlist{} = playlist) do
    Repo.delete(playlist)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking playlist changes.

  ## Examples

      iex> change_playlist(playlist)
      %Ecto.Changeset{data: %Playlist{}}

  """
  def change_playlist(%Playlist{} = playlist, attrs \\ %{}) do
    Playlist.changeset(playlist, attrs)
  end

  alias ElixirGql.Spotify.PlaylistMusica

  @doc """
  Returns the list of playlists_musicas.

  ## Examples

      iex> list_playlists_musicas()
      [%PlaylistMusica{}, ...]

  """
  def list_playlists_musicas do
    Repo.all(PlaylistMusica)
  end

  @doc """
  Gets a single playlist_musica.

  Raises `Ecto.NoResultsError` if the playlist musica does not exist.

  ## Examples

      iex> get_playlist_musica!(123)
      %PlaylistMusica{}

      iex> get_playlist_musica!(456)
      ** (Ecto.NoResultsError)

  """
  def get_playlist_musica!(id), do: Repo.get!(PlaylistMusica, id)

  @doc """
  Creates a playlist_musica.

  ## Examples

      iex> create_playlist_musica(%{field: value})
      {:ok, %PlaylistMusica{}}

      iex> create_playlist_musica(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_playlist_musica(attrs \\ %{}) do
    %PlaylistMusica{}
    |> PlaylistMusica.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a playlist_musica.

  ## Examples

      iex> update_playlist_musica(playlist_musica, %{field: new_value})
      {:ok, %PlaylistMusica{}}

      iex> update_playlist_musica(playlist_musica, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_playlist_musica(%PlaylistMusica{} = playlist_musica, attrs) do
    playlist_musica
    |> PlaylistMusica.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a playlist_musica.

  ## Examples

      iex> delete_playlist_musica(playlist_musica)
      {:ok, %PlaylistMusica{}}

      iex> delete_playlist_musica(playlist_musica)
      {:error, %Ecto.Changeset{}}

  """
  def delete_playlist_musica(%PlaylistMusica{} = playlist_musica) do
    Repo.delete(playlist_musica)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking playlist_musica changes.

  ## Examples

      iex> change_playlist_musica(playlist_musica)
      %Ecto.Changeset{data: %PlaylistMusica{}}

  """
  def change_playlist_musica(%PlaylistMusica{} = playlist_musica, attrs \\ %{}) do
    PlaylistMusica.changeset(playlist_musica, attrs)
  end
end
