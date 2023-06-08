import grpc
import protobuf_pb2 as mypackage_pb2
import protobuf_pb2_grpc as mypackage_pb2_grpc

def run():
    channel = grpc.insecure_channel('localhost:50051')
    stub = mypackage_pb2_grpc.MusicServiceStub(channel)
    
    # List data of all service users
    response_users = stub.ListUsers(mypackage_pb2.ListUsersRequest())
    for user in response_users.users:
        print(f"User ID: {user.id}, Name: {user.name}, Age: {user.age}")

    # List the data of all songs held by the service
    response_songs = stub.ListSongs(mypackage_pb2.ListSongsRequest())
    for song in response_songs.songs:
        print(f"Song ID: {song.id}, Name: {song.name}, Artist: {song.artist}")

    # List the data of all playlists of a given user
    user_id = 1  # Replace with the desired user ID
    response_playlists = stub.ListUserPlaylists(mypackage_pb2.ListUserPlaylistsRequest(user_id=user_id))
    for playlist in response_playlists.playlists:
        print(f"Playlist ID: {playlist.id}, Name: {playlist.name}, User ID: {playlist.user_id}")

    # List data for all songs in a given playlist
    playlist_id = 1  # Replace with the desired playlist ID
    response_playlist_songs = stub.ListPlaylistSongs(mypackage_pb2.ListPlaylistSongsRequest(playlist_id=playlist_id))
    for song in response_playlist_songs.songs:
        print(f"Song ID: {song.id}, Name: {song.name}, Artist: {song.artist}")

    # List the data of all playlists that contain a certain song
    song_id = 1  # Replace with the desired song ID
    response_playlists_by_song = stub.ListPlaylistsBySong(mypackage_pb2.ListPlaylistsBySongRequest(song_id=song_id))
    for playlist in response_playlists_by_song.playlists:
        print(f"Playlist ID: {playlist.id}, Name: {playlist.name}, User ID: {playlist.user_id}")

if __name__ == '__main__':
    run()
