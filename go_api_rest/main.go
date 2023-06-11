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
	ID         int    `json:"id"`
	Nome       string `json:"nome"`
	UsuarioID     int    `json:"usuario_id"`
}

type Musica struct {
	ID      int    `json:"id"`
	Nome    string `json:"nome"`
	Artista string `json:"artista"`
}

var db *sql.DB

const (
	basePathUsuario = "/users"
	basePathPlaylist = "/playlists"
	basePathMusica = "/songs"
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
	router.POST(basePathUsuario, CreateUsuario)
	router.PUT(basePathUsuario+":id", UpdateUsuario)
	router.DELETE(basePathUsuario+"/:id", DeleteUsuario)
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
	err := db.QueryRow("SELECT * FROM Usuario WHERE ID = ?", id).Scan(&usuario.ID, &usuario.Nome, &usuario.Idade)
	if err != nil {
		log.Fatal(err)
	}

	c.JSON(200, usuario)
}

func CreateUsuario(c *gin.Context) {
	var usuario Usuario
	if err := c.ShouldBindJSON(&usuario); err != nil {
		c.JSON(400, gin.H{"error": err.Error()})
		return
	}

	result, err := db.Exec("INSERT INTO Usuario (Nome, Idade) VALUES (?, ?)", usuario.Nome, usuario.Idade)
	if err != nil {
		log.Fatal(err)
	}

	lastInsertID, err := result.LastInsertId()
	if err != nil {
		log.Fatal(err)
	}

	c.JSON(201, gin.H{"id": lastInsertID})
}

func UpdateUsuario(c *gin.Context) {
	id := c.Param("id")

	var usuario Usuario
	if err := c.ShouldBindJSON(&usuario); err != nil {
		c.JSON(400, gin.H{"error": err.Error()})
		return
	}

	_, err := db.Exec("UPDATE Usuario SET Nome = ?, Idade = ? WHERE ID = ?", usuario.Nome, usuario.Idade, id)
	if err != nil {
		log.Fatal(err)
	}

	c.JSON(200, gin.H{"message": "Usuario atualizado com sucesso"})
}

func DeleteUsuario(c *gin.Context) {
	id := c.Param("id")

	_, err := db.Exec("DELETE FROM Usuario WHERE ID = ?", id)
	if err != nil {
		log.Fatal(err)
	}

	c.JSON(200, gin.H{"message": "Usuario removido com sucesso"})
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