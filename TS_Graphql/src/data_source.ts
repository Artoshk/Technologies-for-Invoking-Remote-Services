import { DataSource } from "typeorm";
import { Usuario } from "./entity/Usuario";
import { Playlist } from "./entity/Playlist";
import { Musica } from "./entity/Musica";
import { PlaylistMusica } from "./entity/PlaylistMusica";

let AppDataSource: Promise<DataSource> | undefined;

export const getAppDataSource = () => {
    if (!AppDataSource) {
        AppDataSource = new DataSource({
            type: "mysql",
            host: "localhost",
            port: 3306,
            username: "admin",
            password: "admin",
            database: "dev",
            entities: [
                Usuario,
                Playlist,
                Musica,
                PlaylistMusica
            ],
            synchronize: false,
            logging: false
        }).initialize();
    }
    return AppDataSource;
};
