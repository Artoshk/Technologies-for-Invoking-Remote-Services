const { getAppDataSource } = require('./data_source');
const { Usuario } = require("./entity/Usuario");
const { Playlist } = require("./entity/Playlist");
const { Musica } = require("./entity/Musica");

const { ListUsuariosResponse, ListMusicasResponse, ListPlaylistsUsuarioResponse, ListMusicasPlaylistResponse, ListPlaylistsPorMusicaResponse } = require('./protobuf_pb');
const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');
const path = require('path');

const PROTO_PATH = path.join(__dirname, 'protobuf.proto');
const packageDefinition = protoLoader.loadSync(PROTO_PATH);
const proto = grpc.loadPackageDefinition(packageDefinition).mypackage;

async function listUsuarios(call, callback) {
  try {
    const dataSource = await getAppDataSource();
    const userRepository = dataSource.getRepository(Usuario); // Repositório para a entidade Usuario

    const usuarios = await userRepository.find(); // Exemplo: Obtém todos os usuários do banco de dados
    console.log(usuarios)
    const response = new ListUsuariosResponse();
    response.setUsuariosList(usuarios);
    callback(null, response);
  } catch (error) {
    callback(error);
  }
}

async function listMusicas(call, callback) {
  try {
    const dataSource = await getAppDataSource();
    const musicaRepository = dataSource.getRepository(Musica); // Repositório para a entidade Musica

    const musicas = await musicaRepository.find(); // Exemplo: Obtém todas as músicas do banco de dados
    console.log(musicas)
    const response = new ListMusicasResponse();
    response.setMusicasList(musicas);
    callback(null, response);
  } catch (error) {
    callback(error);
  }
}

async function listPlaylistsUsuario(call, callback) {
  try {
    const dataSource = await getAppDataSource();
    const playlistRepository = dataSource.getRepository(Playlist); // Repositório para a entidade Playlist

    const idUsuario = call.request.getIdUsuario();
    const playlists = await playlistRepository.find({ where: { usuario: { id: idUsuario } } }); // Obtém as playlists do usuário com o ID fornecido
    console.log(playlists)
    const response = new ListPlaylistsUsuarioResponse();
    response.setPlaylistsList(playlists);
    callback(null, response);
  } catch (error) {
    callback(error);
  }
}

async function listMusicasPlaylist(call, callback) {
  try {
    const dataSource = await getAppDataSource();
    const musicaRepository = dataSource.getRepository(Musica); // Repositório para a entidade Musica

    const idPlaylist = call.request.getIdPlaylist();
    const playlistRepository = dataSource.getRepository(Playlist); // Repositório para a entidade Playlist
    const playlist = await playlistRepository.findOne(idPlaylist);
    
    if (!playlist) {
      throw new Error('Playlist not found');
    }

    const musicas = await musicaRepository.createQueryBuilder('musica')
      .innerJoin('musica.playlists', 'playlist')
      .where('playlist.id = :idPlaylist', { idPlaylist })
      .getMany();
    console.log(musicas)
    const response = new ListMusicasPlaylistResponse();
    response.setMusicasList(musicas);
    callback(null, response);
  } catch (error) {
    callback(error);
  }
}

async function listPlaylistsPorMusica(call, callback) {
  try {
    const dataSource = await getAppDataSource();
    const playlistRepository = dataSource.getRepository(Playlist); // Repositório para a entidade Playlist

    const idMusica = call.request.getIdMusica();
    const musicaRepository = dataSource.getRepository(Musica); // Repositório para a entidade Musica
    const musica = await musicaRepository.findOne(idMusica);

    if (!musica) {
      throw new Error('Musica not found');
    }

    const playlists = await playlistRepository.createQueryBuilder('playlist')
      .innerJoin('playlist.musicas', 'musica')
      .where('musica.id = :idMusica', { idMusica })
      .getMany();

    const response = new ListPlaylistsPorMusicaResponse();
    console.log(playlists)
    response.setPlaylistsList(playlists);
    callback(null, response);
  } catch (error) {
    callback(error);
  }
}

function main() {
  const server = new grpc.Server();
  server.addService(proto.MusicService.service, {
    listUsuarios,
    listMusicas,
    listPlaylistsUsuario,
    listMusicasPlaylist,
    listPlaylistsPorMusica
  });
  server.bindAsync('0.0.0.0:50051', grpc.ServerCredentials.createInsecure(), (err, port) => {
    if (err) {
      console.error('Failed to bind:', err);
      return;
    }
    server.start();
    console.log('Server started on port', port);
  });
}

main();