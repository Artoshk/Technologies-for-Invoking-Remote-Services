import { Entity, PrimaryGeneratedColumn, Column, ManyToMany } from 'typeorm';
import { Playlist } from './Playlist';

@Entity()
export class Musica {
  @PrimaryGeneratedColumn({ type: 'int' })
  ID!: number;

  @Column({ type: 'varchar', length: 100, nullable: true })
  Nome: string | undefined;

  @Column({ type: 'varchar', length: 100, nullable: true })
  Artista: string | undefined;

  @ManyToMany(() => Playlist, playlist => playlist.musicas)
  playlists: Playlist[] | undefined;
}
