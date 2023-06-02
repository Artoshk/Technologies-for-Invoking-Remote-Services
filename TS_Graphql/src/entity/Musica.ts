import { Entity, PrimaryGeneratedColumn, Column, ManyToMany } from 'typeorm';
import { Playlist } from './Playlist';
import { Field, ObjectType } from "type-graphql";

@ObjectType()
@Entity()
export class Musica {
  @PrimaryGeneratedColumn({ type: 'int' })
  ID!: number;

  @Field((_type) => String)
  @Column({ type: 'varchar', length: 100, nullable: true })
  Nome: string | undefined;

  @Field((_type) => String)
  @Column({ type: 'varchar', length: 100, nullable: true })
  Artista: string | undefined;

  @Field((_type) => [Playlist])
  @ManyToMany(() => Playlist, playlist => playlist.musicas)
  playlists: Playlist[] | undefined;
}
