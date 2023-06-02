import { Entity, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Playlist } from './Playlist';
import { Musica } from './Musica';
import { Field, ObjectType } from "type-graphql";

@ObjectType()
@Entity()
export class PlaylistMusica {
  @PrimaryGeneratedColumn({ type: 'int' })
  ID!: number;

  @Field((_type) => Playlist)
  @ManyToOne(() => Playlist, playlist => playlist.ID)
  @JoinColumn({ name: 'Playlist_ID' })
  playlist: Playlist | undefined;

  @Field((_type) => Musica)
  @ManyToOne(() => Musica, musica => musica.ID)
  @JoinColumn({ name: 'Musica_ID' })
  musica: Musica | undefined;
}
