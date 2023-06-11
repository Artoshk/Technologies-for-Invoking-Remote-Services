from zeep import Client

# Create a Zeep client pointing to the WSDL file of the SOAP API
wsdl = 'http://localhost:8000/?wsdl'  # Update with the appropriate WSDL URL
client = Client(wsdl=wsdl)

# Call the SOAP methods
users = client.service.get_all_users()
print("Users:")
for user in users:
    print(f"ID: {user.ID}, Nome: {user.Nome}, Idade: {user.Idade}")

print()

songs = client.service.get_all_songs()
print("Songs:")
for song in songs:
    print(f"ID: {song.ID}, Nome: {song.Nome}, Artista: {song.Artista}")

print()

user_playlists = client.service.get_user_playlists(user='1')
print("User Playlists:")
for playlist in user_playlists:
    print(f"ID: {playlist.ID}, Nome: {playlist.Nome}, Usuario_ID: {playlist.Usuario_ID}")

print()

playlist_songs = client.service.get_playlist_songs(playlist='1')
print("Playlist Songs:")
for song in playlist_songs:
    print(f"ID: {song.ID}, Nome: {song.Nome}, Artista: {song.Artista}")

print()

song_playlists = client.service.get_song_playlists(song='1')
print("Song Playlists:")
for playlist in song_playlists:
    print(f"ID: {playlist.ID}, Nome: {playlist.Nome}, Usuario_ID: {playlist.Usuario_ID}")
