import { Resolver, Query, FieldResolver, Arg, Root, Mutation, Ctx, Int } from "type-graphql";
import { Repository } from "typeorm";
import { InjectRepository } from "typeorm-typedi-extensions";
import { Service } from "typedi";

import { PlaylistMusica } from "../entity/PlaylistMusica";
import { PlaylistMusicaInput } from "./types/playlistMusica-input";
import { Playlist } from "../entity/Playlist";
import { Musica } from "../entity/Musica";


@Service()
@Resolver((_of) => PlaylistMusica)
export class PlaylistMusicaResolver {
    constructor(
        @InjectRepository(PlaylistMusica) private readonly playlistMusicaRepository: Repository<PlaylistMusica>,
        @InjectRepository(Playlist) private readonly playlistRepository: Repository<Playlist>,
        @InjectRepository(Musica) private readonly musicaRepository: Repository<Musica>,
    ) {}
    
    @Query((_returns) => PlaylistMusica, { nullable: true })
    async playlistMusica(@Arg("id", (_type) => Int) id: number) {
        return this.playlistMusicaRepository.findOne(id);
    }
    
    @Query((_returns) => [PlaylistMusica])
    async playlistMusicas() {
        return this.playlistMusicaRepository.find();
    }
    
    @FieldResolver((_type) => Playlist)
    async playlist(@Root() playlistMusica: PlaylistMusica) {
        return this.playlistRepository.findOne(playlistMusica.Playlist_ID);
    }
    
    @FieldResolver((_type) => Musica)
    async musica(@Root() playlistMusica: PlaylistMusica) {
        return this.musicaRepository.findOne(playlistMusica.Musica_ID);
    }
    
    @Mutation((_returns) => PlaylistMusica)
    async addPlaylistMusica(
        @Arg("data") playlistMusicaInput: PlaylistMusicaInput,
        @Ctx() { user }: any
    ) {
        const playlistMusica = new PlaylistMusica();
        playlistMusica.Playlist_ID = playlistMusicaInput.Playlist_ID;
        playlistMusica.Musica_ID = playlistMusicaInput.Musica_ID;
        return this.playlistMusicaRepository.save(playlistMusica);
    }
    
    @Mutation((_returns) => PlaylistMusica)
    async updatePlaylistMusica(
        @Arg("id", (_type) => Int) id: number,
        @Arg("data") playlistMusicaInput: PlaylistMusicaInput,
        @Ctx() { user }: any
    ) {
        const playlistMusica = await this.playlistMusicaRepository.findOne(id);
        if (!playlistMusica) throw new Error("PlaylistMusica not found!");
        Object.assign(playlistMusica, playlistMusicaInput);
        return this.playlistMusicaRepository.save(playlistMusica);
    }
    
    @Mutation((_returns) => Boolean)
    async deletePlaylistMusica(
        @Arg("id", (_type) => Int) id: number,
        @Ctx() { user }: any
    ) {