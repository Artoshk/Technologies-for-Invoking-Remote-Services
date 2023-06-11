import requests
import json

BASE_URL = "http://localhost:8081"

def get_all_users():
    response = requests.get(f"{BASE_URL}/users")
    if response.status_code == 200:
        users = json.loads(response.text)
        return users
    else:
        print("Failed to retrieve users.")
        return []

def get_user_by_id(user_id):
    response = requests.get(f"{BASE_URL}/users/{user_id}")
    if response.status_code == 200:
        user = json.loads(response.text)
        return user
    else:
        print(f"Failed to retrieve user with ID: {user_id}.")
        return None

def create_user(user_data):
    headers = {'Content-type': 'application/json'}
    response = requests.post(f"{BASE_URL}/users", data=json.dumps(user_data), headers=headers)
    if response.status_code == 201:
        print("User created successfully.")
    else:
        print("Failed to create user.")

def update_user(user_id, user_data):
    headers = {'Content-type': 'application/json'}
    response = requests.put(f"{BASE_URL}/users/{user_id}", data=json.dumps(user_data), headers=headers)
    if response.status_code == 200:
        print("User updated successfully.")
    else:
        print(f"Failed to update user with ID: {user_id}.")

def delete_user(user_id):
    response = requests.delete(f"{BASE_URL}/users/{user_id}")
    if response.status_code == 200:
        print("User deleted successfully.")
    else:
        print(f"Failed to delete user with ID: {user_id}.")

def get_playlists_by_user_id(user_id):
    response = requests.get(f"{BASE_URL}/playlists/users/{user_id}")
    if response.status_code == 200:
        playlists = json.loads(response.text)
        return playlists
    else:
        print(f"Failed to retrieve playlists for user with ID: {user_id}.")
        return []

def get_songs_by_playlist_id(playlist_id):
    response = requests.get(f"{BASE_URL}/playlists/{playlist_id}/songs")
    if response.status_code == 200:
        songs = json.loads(response.text)
        return songs
    else:
        print(f"Failed to retrieve songs for playlist with ID: {playlist_id}.")
        return []

def get_playlists_by_song_id(song_id):
    response = requests.get(f"{BASE_URL}/songs/{song_id}/playlists")
    if response.status_code == 200:
        playlists = json.loads(response.text)
        return playlists
    else:
        print(f"Failed to retrieve playlists for song with ID: {song_id}.")
        return []

# Usage examples:
users = get_all_users()
print(users)

user = get_user_by_id(1)
print(user)

# new_user = {
#     "nome": "John Doe",
#     "idade": 30
# }
# create_user(new_user)

# updated_user = {
#     "nome": "Jane Smith",
#     "idade": 25
# }
# update_user(1, updated_user)

# delete_user(1)

playlists = get_playlists_by_user_id(1)
print(playlists)

songs = get_songs_by_playlist_id(1)
print(songs)

playlists = get_playlists_by_song_id(1)
print(playlists)
