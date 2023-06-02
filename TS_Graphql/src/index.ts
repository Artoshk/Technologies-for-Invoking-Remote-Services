import { getAppDataSource } from "./data_source";
import { Usuario } from "./entity/Usuario";
import { Playlist } from "./entity/Playlist";
import { Musica } from "./entity/Musica";
import { PlaylistMusica } from "./entity/PlaylistMusica";

(async () => {
    getAppDataSource().then(async (AppDataSource) => {
        console.log("Data Source has been initialized!")
        const usuarios = AppDataSource.manager.find(Usuario);
        console.log(await usuarios);
        const playlists = AppDataSource.manager.find(Playlist);
        console.log(await playlists);
        const musicas = AppDataSource.manager.find(Musica);
        console.log(await musicas);
        const playlistMusicas = AppDataSource.manager.find(PlaylistMusica);
        console.log(await playlistMusicas);
    })
    .catch((err) => {
        console.error("Error during Data Source initialization", err)
    })
})();


