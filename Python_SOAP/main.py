from spyne.model.complex import Array, ComplexModel
from spyne import Application, rpc, ServiceBase, String
from spyne.protocol.soap import Soap11
from spyne.server.wsgi import WsgiApplication
from wsgiref.simple_server import make_server
import psycopg2

# TO DO: Adicionar tipos complexos na API para retornar *todos* os dados de cada tabela

class SoapAPI(ServiceBase):
    # List data of all service users
    @rpc(_returns=Array(String))
    def get_all_users(self):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Usuario")
        values = cursor.fetchall()
        print(values)
        users = [row[1] for row in values]
        cursor.close()
        conn.close()
        return users
    
    # List the data of all songs held by the service
    @rpc(_returns=Array(String))
    def get_all_songs(self):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT Nome FROM Musica")
        songs = [row[0] for row in cursor.fetchall()]
        conn.close()
        return songs
    
    # List the data of all playlists of a given user
    @rpc(String, _returns=Array(String))
    def get_user_playlists(self, user):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Playlist WHERE Usuario_ID = {}".format(user))
        playlists = [row[1] for row in cursor.fetchall()]
        conn.close()
        return playlists

    # List data for all songs in a given playlist
    @rpc(String, _returns=Array(String))
    def get_playlist_songs(self, playlist):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT Musica.Nome FROM Musica JOIN Playlist_Musica ON Musica.ID = Playlist_Musica.Musica_ID WHERE Playlist_Musica.Playlist_ID = {}".format(playlist))
        songs = [row[0] for row in cursor.fetchall()]
        conn.close()
        return songs
    
    # List the data of all playlists that contain a certain song
    @rpc(String, _returns=Array(String))
    def get_song_playlists(self, song):
        conn = psycopg2.connect(user='postgres', password='postgres',
                                database='postgres', host='127.0.0.1')
        cursor = conn.cursor()
        cursor.execute("SELECT Playlist.Nome FROM Playlist JOIN Playlist_Musica ON Playlist.ID = Playlist_Musica.Playlist_ID WHERE Playlist_Musica.Musica_ID = {}".format(song))
        playlists = [row[0] for row in cursor.fetchall()]
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
