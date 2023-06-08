from spyne.model.complex import Array, ComplexModel
from spyne import Application, rpc, ServiceBase, String, Integer
from spyne.protocol.soap import Soap11
from spyne.server.wsgi import WsgiApplication
from wsgiref.simple_server import make_server
import psycopg2

class Usuario(ComplexModel):
    __namespace__ = 'your.namespace'
    ID = Integer
    Nome = String
    Idade = Integer

class Playlist(ComplexModel):
    __namespace__ = 'your.namespace'
    ID = Integer
    Nome = String
    Usuario_ID = Integer

class Musica(ComplexModel):
    __namespace__ = 'your.namespace'
    ID = Integer
    Nome = String
    Artista = String

class PlaylistMusica(ComplexModel):
    __namespace__ = 'your.namespace'
    ID = Integer
    Playlist_ID = Integer
    Musica_ID = Integer

class SoapAPI(ServiceBase):
    # List data of all service users
    @rpc(_returns=Array(Usuario))
    def get_all_users(self):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Usuario")
        values = cursor.fetchall()
        users = []
        for row in values:
            user = Usuario()
            user.ID = row[0]
            user.Nome = row[1]
            user.Idade = row[2]
            users.append(user)
        cursor.close()
        conn.close()
        return users
    
    # List the data of all songs held by the service
    @rpc(_returns=Array(Musica))
    def get_all_songs(self):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Musica")
        values = cursor.fetchall()
        songs = []
        for row in values:
            song = Musica()
            song.ID = row[0]
            song.Nome = row[1]
            song.Artista = row[2]
            songs.append(song)
        cursor.close()
        conn.close()
        return songs
    
    # List the data of all playlists of a given user
    @rpc(String, _returns=Array(Playlist))
    def get_user_playlists(self, user):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Playlist WHERE Usuario_ID = {}".format(user))
        values = cursor.fetchall()
        playlists = []
        for row in values:
            playlist = Playlist()
            playlist.ID = row[0]
            playlist.Nome = row[1]
            playlist.Usuario_ID = row[2]
            playlists.append(playlist)
        cursor.close()
        conn.close()
        return playlists

    # List data for all songs in a given playlist
    @rpc(String, _returns=Array(Musica))
    def get_playlist_songs(self, playlist):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT Musica.* FROM Musica JOIN Playlist_Musica ON Musica.ID = Playlist_Musica.Musica_ID WHERE Playlist_Musica.Playlist_ID = {}".format(playlist))
        values = cursor.fetchall()
        songs = []
        for row in values:
            song = Musica()
            song.ID = row[0]
            song.Nome = row[1]
            song.Artista = row[2]
            songs.append(song)
        cursor.close()
        conn.close()
        return songs
    
    # List the data of all playlists that contain a certain song
    @rpc(String, _returns=Array(Playlist))
    def get_song_playlists(self, song):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT Playlist.* FROM Playlist JOIN Playlist_Musica ON Playlist.ID = Playlist_Musica.Playlist_ID WHERE Playlist_Musica.Musica_ID = {}".format(song))
        values = cursor.fetchall()
        playlists = []
        for row in values:
            playlist = Playlist()
            playlist.ID = row[0]
            playlist.Nome = row[1]
            playlist.Usuario_ID = row[2]
            playlists.append(playlist)
        cursor.close()
        conn.close()
        return playlists

if __name__ == '__main__':
    # Create a SOAP application with the SoapAPI service
    soap_app = Application([SoapAPI], 'your.namespace',
                           in_protocol=Soap11(validator='lxml'),
                           out_protocol=Soap11())

    # Create a WSGI application using the SOAP application
    wsgi_app = WsgiApplication(soap_app)

    # Create a WSGI server and run the application on a local development server
    server = make_server('localhost', 8000, wsgi_app)
    print("SOAP API server started on http://localhost:8000")
    server.serve_forever()
