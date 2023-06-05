import { Entity, PrimaryGeneratedColumn, Column, ManyToMany } from 'typeorm';
import { Playlist } from './Playlist';

@Entity('musica', {synchronize: false})
export class Musica {
  @PrimaryGeneratedColumn({ type: 'int', name: 'id' })
  ID!: number;

  @Column({ type: 'varchar', length: 100, nullable: true, name: 'nome' })
  Nome: string | undefined;

  @Column({ type: 'varchar', length: 100, nullable: true, name: 'artista' })
  Artista: string | undefined;

  @ManyToMany(() => Playlist, playlist => playlist.musicas)
  playlists: Playlist[] | undefined;
}
