package main

import (
	"database/sql"
	"log"
	"strconv"

	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

type Usuario struct {
	ID    int    `json:"id"`
	Nome  string `json:"nome"`
	Idade int    `json:"idade"`
}

type Playlist struct {
	ID        int    `json:"id"`
	Nome      string `json:"nome"`
	UsuarioID int    `json:"usuario_id"`
}

type Musica struct {
	ID      int    `json:"id"`
	Nome    string `json:"nome"`
	Artista string `json:"artista"`
}

var db *sql.DB

const (
	basePathUsuario  = "/users"
	basePathPlaylist = "/playlists"
	basePathMusica   = "/songs"
	connectionString = "host=localhost port=5432 user=postgres password=postgres dbname=postgres sslmode=disable"
)

func main() {
	var err error
	db, err = sql.Open("postgres", connectionString)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}

	router := gin.Default()

	router.GET(basePathUsuario, GetUsuarios)
	router.GET(basePathUsuario+"/:id", GetUsuarioByID)
	router.GET(basePathPlaylist, GetPlaylists)
	router.GET(basePathPlaylist+"/:id", GetPlaylistByID)
	router.GET(basePathMusica, GetMusicas)
	router.GET(basePathMusica+"/:id", GetMusicaByID)
	router.GET(basePathPlaylist+"/users/:id", GetPlaylistsByUsuarioID)
	router.GET(basePathPlaylist+"/:id/songs", GetMusicasByPlaylistID)
	router.GET(basePathMusica+"/:id/playlists", GetPlaylistsByMusicaID)

	log.Fatal(router.Run(":8081"))
}

func GetUsuarios(c *gin.Context) {
	rows, err := db.Query("SELECT * FROM Usuario")
	if err != nil {
		log.Fatal(err)
	}

	var usuarios []Usuario
	for rows.Next() {
		var usuario Usuario
		err := rows.Scan(&usuario.ID, &usuario.Nome, &usuario.Idade)
		if err != nil {
			log.Fatal(err)
		}
		usuarios = append(usuarios, usuario)
	}

	c.JSON(200, usuarios)
}

func GetUsuarioByID(c *gin.Context) {
	id := c.Param("id")

	var usuario Usuario
	err := db.QueryRow("SELECT * FROM Usuario WHERE ID = $1", id).Scan(&usuario.ID, &usuario.Nome, &usuario.Idade)
	if err != nil {
		if err == sql.ErrNoRows {
			c.JSON(404, gin.H{"error": "Usuário não encontrado"})
			return
		}
		c.JSON(500, gin.H{"error": "Erro ao obter o usuário"})
		return
	}

	c.JSON(200, usuario)
}

func GetPlaylists(c *gin.Context) {
	rows, err := db.Query("SELECT * FROM Playlist")
	if err != nil {
		if err == sql.ErrNoRows {
			c.JSON(404, gin.H{"error": "Nenhuma playlist encontrada"})
			return
		}
		c.JSON(500, gin.H{"error": "Erro ao obter as playlists"})
		return
	}

	var playlists []Playlist
	for rows.Next() {
		var playlist Playlist
		err := rows.Scan(&playlist.ID, &playlist.Nome, &playlist.UsuarioID)
		if err != nil {
			log.Fatal(err)
		}
		playlists = append(playlists, playlist)
	}

	c.JSON(200, playlists)
}

func GetPlaylistByID(c *gin.Context) {
	id := c.Param("id")

	var playlist Playlist
	err := db.QueryRow("SELECT * FROM Playlist WHERE ID = $1", id).Scan(&playlist.ID, &playlist.Nome, &playlist.UsuarioID)
	if err != nil {
		if err == sql.ErrNoRows {
			c.JSON(404, gin.H{"error": "Playlist não encontrada"})
			return
		}
		c.JSON(500, gin.H{"error": "Erro ao obter a playlist"})
		return
	}

	c.JSON(200, playlist)
}

func GetMusicas(c *gin.Context) {
	rows, err := db.Query("SELECT * FROM Musica")
	if err != nil {
		if err == sql.ErrNoRows {
			c.JSON(404, gin.H{"error": "Nenhuma música encontrada"})
			return
		}
		c.JSON(500, gin.H{"error": "Erro ao obter as músicas"})
		return
	}

	var musicas []Musica
	for rows.Next() {
		var musica Musica
		err := rows.Scan(&musica.ID, &musica.Nome, &musica.Artista)
		if err != nil {
			log.Fatal(err)
		}
		musicas = append(musicas, musica)
	}

	c.JSON(200, musicas)
}

func GetMusicaByID(c *gin.Context) {
	id := c.Param("id")

	var musica Musica
	err := db.QueryRow("SELECT * FROM Musica WHERE ID = $1", id).Scan(&musica.ID, &musica.Nome, &musica.Artista)
	if err != nil {
		if err == sql.ErrNoRows {
			c.JSON(404, gin.H{"error": "Música não encontrada"})
			return
		}
		c.JSON(500, gin.H{"error": "Erro ao obter a música"})
		return
	}

	c.JSON(200, musica)
}

func GetPlaylistsByUsuarioID(c *gin.Context) {
	usuarioID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(400, gin.H{"error": "ID do usuário inválido"})
		return
	}

	playlists, err := getPlaylistsByUsuarioID(usuarioID)
	if err != nil {
		log.Fatal(err)
		c.JSON(500, gin.H{"error": "Falha ao obter as playlists do usuário"})
		return
	}

	c.JSON(200, playlists)
}

func getPlaylistsByUsuarioID(usuarioID int) ([]Playlist, error) {
	rows, err := db.Query("SELECT id, nome, usuario_id FROM playlist WHERE usuario_id = $1", usuarioID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var playlists []Playlist

	for rows.Next() {
		var playlist Playlist
		err := rows.Scan(&playlist.ID, &playlist.Nome, &playlist.UsuarioID)
		if err != nil {
			return nil, err
		}
		playlists = append(playlists, playlist)
	}

	return playlists, nil
}

func GetMusicasByPlaylistID(c *gin.Context) {
	playlistID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(400, gin.H{"error": "ID da playlist inválido"})
		return
	}

	musicas, err := getMusicasByPlaylistID(playlistID)
	if err != nil {
		log.Fatal(err)
		c.JSON(500, gin.H{"error": "Falha ao obter as músicas da playlist"})
		return
	}

	c.JSON(200, musicas)
}

func getMusicasByPlaylistID(playlistID int) ([]Musica, error) {
	rows, err := db.Query("SELECT musica.id, musica.nome, musica.artista FROM musica JOIN playlist_musica ON musica.id = playlist_musica.musica_id WHERE playlist_musica.playlist_id = $1", playlistID)
	if err != nil {
		log.Fatal(err)
		return nil, err
	}
	defer rows.Close()

	var musicas []Musica

	for rows.Next() {
		var musica Musica
		err := rows.Scan(&musica.ID, &musica.Nome, &musica.Artista)
		if err != nil {
			return nil, err
		}
		musicas = append(musicas, musica)
	}

	return musicas, nil
}

func GetPlaylistsByMusicaID(c *gin.Context) {
	musicaID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(400, gin.H{"error": "ID da musica inválido"})
		return
	}

	playlists, err := getPlaylistsByMusicaID(musicaID)
	if err != nil {
		log.Fatal(err)
		c.JSON(500, gin.H{"error": "Falha ao obter as playslists da musica"})
		return
	}

	c.JSON(200, playlists)
}

func getPlaylistsByMusicaID(musicaID int) ([]Playlist, error) {
	rows, err := db.Query("SELECT playlist.id, playlist.nome FROM playlist JOIN playlist_musica ON playlist.id = playlist_musica.playlist_id WHERE playlist_musica.musica_id = $1", musicaID)
	if err != nil {
		log.Fatal(err)
		return nil, err
	}
	defer rows.Close()

	var playlists []Playlist

	for rows.Next() {
		var playlist Playlist
		err := rows.Scan(&playlist.ID, &playlist.Nome)
		if err != nil {
			return nil, err
		}
		playlists = append(playlists, playlist)
	}

	return playlists, nil
}
