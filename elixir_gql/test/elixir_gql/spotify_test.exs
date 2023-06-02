defmodule ElixirGql.SpotifyTest do
  use ElixirGql.DataCase

  alias ElixirGql.Spotify

  describe "usuarios" do
    alias ElixirGql.Spotify.Usuario

    import ElixirGql.SpotifyFixtures

    @invalid_attrs %{idade: nil, nome: nil}

    test "list_usuarios/0 returns all usuarios" do
      usuario = usuario_fixture()
      assert Spotify.list_usuarios() == [usuario]
    end

    test "get_usuario!/1 returns the usuario with given id" do
      usuario = usuario_fixture()
      assert Spotify.get_usuario!(usuario.id) == usuario
    end

    test "create_usuario/1 with valid data creates a usuario" do
      valid_attrs = %{idade: 42, nome: "some nome"}

      assert {:ok, %Usuario{} = usuario} = Spotify.create_usuario(valid_attrs)
      assert usuario.idade == 42
      assert usuario.nome == "some nome"
    end

    test "create_usuario/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spotify.create_usuario(@invalid_attrs)
    end

    test "update_usuario/2 with valid data updates the usuario" do
      usuario = usuario_fixture()
      update_attrs = %{idade: 43, nome: "some updated nome"}

      assert {:ok, %Usuario{} = usuario} = Spotify.update_usuario(usuario, update_attrs)
      assert usuario.idade == 43
      assert usuario.nome == "some updated nome"
    end

    test "update_usuario/2 with invalid data returns error changeset" do
      usuario = usuario_fixture()
      assert {:error, %Ecto.Changeset{}} = Spotify.update_usuario(usuario, @invalid_attrs)
      assert usuario == Spotify.get_usuario!(usuario.id)
    end

    test "delete_usuario/1 deletes the usuario" do
      usuario = usuario_fixture()
      assert {:ok, %Usuario{}} = Spotify.delete_usuario(usuario)
      assert_raise Ecto.NoResultsError, fn -> Spotify.get_usuario!(usuario.id) end
    end

    test "change_usuario/1 returns a usuario changeset" do
      usuario = usuario_fixture()
      assert %Ecto.Changeset{} = Spotify.change_usuario(usuario)
    end
  end

  describe "musicas" do
    alias ElixirGql.Spotify.Musica

    import ElixirGql.SpotifyFixtures

    @invalid_attrs %{artista: nil, nome: nil}

    test "list_musicas/0 returns all musicas" do
      musica = musica_fixture()
      assert Spotify.list_musicas() == [musica]
    end

    test "get_musica!/1 returns the musica with given id" do
      musica = musica_fixture()
      assert Spotify.get_musica!(musica.id) == musica
    end

    test "create_musica/1 with valid data creates a musica" do
      valid_attrs = %{artista: "some artista", nome: "some nome"}

      assert {:ok, %Musica{} = musica} = Spotify.create_musica(valid_attrs)
      assert musica.artista == "some artista"
      assert musica.nome == "some nome"
    end

    test "create_musica/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spotify.create_musica(@invalid_attrs)
    end

    test "update_musica/2 with valid data updates the musica" do
      musica = musica_fixture()
      update_attrs = %{artista: "some updated artista", nome: "some updated nome"}

      assert {:ok, %Musica{} = musica} = Spotify.update_musica(musica, update_attrs)
      assert musica.artista == "some updated artista"
      assert musica.nome == "some updated nome"
    end

    test "update_musica/2 with invalid data returns error changeset" do
      musica = musica_fixture()
      assert {:error, %Ecto.Changeset{}} = Spotify.update_musica(musica, @invalid_attrs)
      assert musica == Spotify.get_musica!(musica.id)
    end

    test "delete_musica/1 deletes the musica" do
      musica = musica_fixture()
      assert {:ok, %Musica{}} = Spotify.delete_musica(musica)
      assert_raise Ecto.NoResultsError, fn -> Spotify.get_musica!(musica.id) end
    end

    test "change_musica/1 returns a musica changeset" do
      musica = musica_fixture()
      assert %Ecto.Changeset{} = Spotify.change_musica(musica)
    end
  end

  describe "playlists" do
    alias ElixirGql.Spotify.Playlist

    import ElixirGql.SpotifyFixtures

    @invalid_attrs %{nome: nil}

    test "list_playlists/0 returns all playlists" do
      playlist = playlist_fixture()
      assert Spotify.list_playlists() == [playlist]
    end

    test "get_playlist!/1 returns the playlist with given id" do
      playlist = playlist_fixture()
      assert Spotify.get_playlist!(playlist.id) == playlist
    end

    test "create_playlist/1 with valid data creates a playlist" do
      valid_attrs = %{nome: "some nome"}

      assert {:ok, %Playlist{} = playlist} = Spotify.create_playlist(valid_attrs)
      assert playlist.nome == "some nome"
    end

    test "create_playlist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spotify.create_playlist(@invalid_attrs)
    end

    test "update_playlist/2 with valid data updates the playlist" do
      playlist = playlist_fixture()
      update_attrs = %{nome: "some updated nome"}

      assert {:ok, %Playlist{} = playlist} = Spotify.update_playlist(playlist, update_attrs)
      assert playlist.nome == "some updated nome"
    end

    test "update_playlist/2 with invalid data returns error changeset" do
      playlist = playlist_fixture()
      assert {:error, %Ecto.Changeset{}} = Spotify.update_playlist(playlist, @invalid_attrs)
      assert playlist == Spotify.get_playlist!(playlist.id)
    end

    test "delete_playlist/1 deletes the playlist" do
      playlist = playlist_fixture()
      assert {:ok, %Playlist{}} = Spotify.delete_playlist(playlist)
      assert_raise Ecto.NoResultsError, fn -> Spotify.get_playlist!(playlist.id) end
    end

    test "change_playlist/1 returns a playlist changeset" do
      playlist = playlist_fixture()
      assert %Ecto.Changeset{} = Spotify.change_playlist(playlist)
    end
  end

  describe "playlists_musicas" do
    alias ElixirGql.Spotify.PlaylistMusica

    import ElixirGql.SpotifyFixtures

    @invalid_attrs %{}

    test "list_playlists_musicas/0 returns all playlists_musicas" do
      playlist_musica = playlist_musica_fixture()
      assert Spotify.list_playlists_musicas() == [playlist_musica]
    end

    test "get_playlist_musica!/1 returns the playlist_musica with given id" do
      playlist_musica = playlist_musica_fixture()
      assert Spotify.get_playlist_musica!(playlist_musica.id) == playlist_musica
    end

    test "create_playlist_musica/1 with valid data creates a playlist_musica" do
      valid_attrs = %{}

      assert {:ok, %PlaylistMusica{} = playlist_musica} = Spotify.create_playlist_musica(valid_attrs)
    end

    test "create_playlist_musica/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spotify.create_playlist_musica(@invalid_attrs)
    end

    test "update_playlist_musica/2 with valid data updates the playlist_musica" do
      playlist_musica = playlist_musica_fixture()
      update_attrs = %{}

      assert {:ok, %PlaylistMusica{} = playlist_musica} = Spotify.update_playlist_musica(playlist_musica, update_attrs)
    end

    test "update_playlist_musica/2 with invalid data returns error changeset" do
      playlist_musica = playlist_musica_fixture()
      assert {:error, %Ecto.Changeset{}} = Spotify.update_playlist_musica(playlist_musica, @invalid_attrs)
      assert playlist_musica == Spotify.get_playlist_musica!(playlist_musica.id)
    end

    test "delete_playlist_musica/1 deletes the playlist_musica" do
      playlist_musica = playlist_musica_fixture()
      assert {:ok, %PlaylistMusica{}} = Spotify.delete_playlist_musica(playlist_musica)
      assert_raise Ecto.NoResultsError, fn -> Spotify.get_playlist_musica!(playlist_musica.id) end
    end

    test "change_playlist_musica/1 returns a playlist_musica changeset" do
      playlist_musica = playlist_musica_fixture()
      assert %Ecto.Changeset{} = Spotify.change_playlist_musica(playlist_musica)
    end
  end
end
