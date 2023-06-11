const { ListUsuariosRequest, ListMusicasRequest, ListPlaylistsUsuarioRequest, ListMusicasPlaylistRequest, ListPlaylistsPorMusicaRequest } = require('./protobuf_pb');
const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');
const path = require('path');

const PROTO_PATH = path.join(__dirname, 'protobuf.proto');
const packageDefinition = protoLoader.loadSync(PROTO_PATH);
const proto = grpc.loadPackageDefinition(packageDefinition).mypackage;

const client = new proto.MusicService('localhost:50051', grpc.credentials.createInsecure());

function listUsuarios() {
  const request = new ListUsuariosRequest();

  client.listUsuarios(request, (error, response) => {
    if (error) {
      console.error('Error:', error);
      return;
    }
    console.log('Response:', response);

    const users = response.getUsuariosList();
    console.log('Users:', users);
  });
}

function listMusicas() {
  const request = new ListMusicasRequest();

  client.listMusicas(request, (error, response) => {
    if (error) {
      console.error('Error:', error);
      return;
    }
    console.log('Response:', response);

    const musicas = response.getMusicasList();
    console.log('Musicas:', musicas);
  });
}

function listPlaylistsUsuario(idUsuario) {
  const request = new ListPlaylistsUsuarioRequest();
  request.setIdUsuario(idUsuario);

  client.listPlaylistsUsuario(request, (error, response) => {
    if (error) {
      console.error('Error:', error);
      return;
    }
    console.log('Response:', response);

    const playlists = response.getPlaylistsList();
    console.log('Playlists:', playlists);
  });
}

function listMusicasPlaylist(idPlaylist) {
  const request = new ListMusicasPlaylistRequest();
  request.setIdPlaylist(idPlaylist);

  client.listMusicasPlaylist(request, (error, response) => {
    if (error) {
      console.error('Error:', error);
      return;
    }
    console.log('Response:', response);

    const musicas = response.getMusicasList();
    console.log('Musicas:', musicas);
  });
}

function listPlaylistsPorMusica(idMusica) {
  const request = new ListPlaylistsPorMusicaRequest();
  request.setIdMusica(idMusica);

  client.listPlaylistsPorMusica(request, (error, response) => {
    if (error) {
      console.error('Error:', error);
      return;
    }
    console.log('Response:', response);

    const playlists = response.getPlaylistsList();
    console.log('Playlists:', playlists);
  });
}

// Exemplos de chamadas aos métodos do servidor gRPC
listUsuarios();
listMusicas();
listPlaylistsUsuario(1); // ID do usuário desejado
listMusicasPlaylist(1); // ID da playlist desejada
listPlaylistsPorMusica(1); // ID da música desejada
