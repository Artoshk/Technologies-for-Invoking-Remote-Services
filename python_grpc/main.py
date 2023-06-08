import grpc
from concurrent import futures
import protobuf_pb2 as mypackage_pb2
import protobuf_pb2_grpc as mypackage_pb2_grpc
import psycopg2

class MusicServiceServicer(mypackage_pb2_grpc.MusicServiceServicer):
    # List data of all service users
    def ListUsers(self, request, context):
        conn = psycopg2.connect(
            host="localhost",
            database="postgres",
            user="postgres",
            password="postgres"
        )
        cur = conn.cursor()
        cur.execute("SELECT * FROM Usuario;")
        rows = cur.fetchall()
        users = []
        for row in rows:
            user = mypackage_pb2.User(
                id=row[0],
                name=row[1],
                age=row[2]
            )
            users.append(user)
        cur.close()
        conn.close()
        return mypackage_pb2.ListUsersResponse(users=users)

    # List the data of all songs held by the service
    def ListSongs(self, request, context):
        conn = psycopg2.connect(
            host="localhost",
            database="postgres",
            user="postgres",
            password="postgres"
        )
        cur = conn.cursor()
        cur.execute("SELECT * FROM Musica;")
        rows = cur.fetchall()
        songs = []
        for row in rows:
            song = mypackage_pb2.Song(
                id=row[0],
                name=row[1],
                artist=row[2]
            )
            songs.append(song)
        cur.close()
        conn.close()
        return mypackage_pb2.ListSongsResponse(songs=songs)

    # List the data of all playlists of a given user
    def ListUserPlaylists(self, request, context):
        conn = psycopg2.connect(
            host="localhost",
            database="postgres",
            user="postgres",
            password="postgres"
        )
        cur = conn.cursor()
        cur.execute("SELECT * FROM Playlist WHERE Usuario_ID = %s;", (request.user_id,))
        rows = cur.fetchall()
        playlists = []
        for row in rows:
            playlist = mypackage_pb2.Playlist(
                id=row[0],
                name=row[1],
                user_id=row[2]
            )
            playlists.append(playlist)
        cur.close()
        conn.close()
        return mypackage_pb2.ListUserPlaylistsResponse(playlists=playlists)

    # List data for all songs in a given playlist
    def ListPlaylistSongs(self, request, context):
        conn = psycopg2.connect(
            host="localhost",
            database="postgres",
            user="postgres",
            password="postgres"
        )
        cur = conn.cursor()
        cur.execute("SELECT Musica.* FROM Musica INNER JOIN Playlist_Musica ON Musica.ID = Playlist_Musica.Musica_ID WHERE Playlist_Musica.Playlist_ID = %s;", (request.playlist_id,))
        rows = cur.fetchall()
        songs = []
        for row in rows:
            song = mypackage_pb2.Song(
                id=row[0],
                name=row[1],
                artist=row[2]
            )
            songs.append(song)
        cur.close()
        conn.close()
        return mypackage_pb2.ListPlaylistSongsResponse(songs=songs)

    # List the data of all playlists that contain a certain song
    def ListPlaylistsBySong(self, request, context):
        conn = psycopg2.connect(
            host="localhost",
            database="postgres",
            user="postgres",
            password="postgres"
        )
        cur = conn.cursor()
        cur.execute("SELECT Playlist.* FROM Playlist INNER JOIN Playlist_Musica ON Playlist.ID = Playlist_Musica.Playlist_ID WHERE Playlist_Musica.Musica_ID = %s;", (request.song_id,))
        rows = cur.fetchall()
        playlists = []
        for row in rows:
            playlist = mypackage_pb2.Playlist(
                id=row[0],
                name=row[1],
                user_id=row[2]
            )
            playlists.append(playlist)
        cur.close()
        conn.close()
        return mypackage_pb2.ListPlaylistsBySongResponse(playlists=playlists)
    
def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    mypackage_pb2_grpc.add_MusicServiceServicer_to_server(MusicServiceServicer(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    server.wait_for_termination()

if __name__ == '__main__':
    serve()
