import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { Playlist } from './Playlist';
import { Field, ObjectType } from "type-graphql";

@ObjectType()
@Entity('Usuario', {synchronize: false})
export class Usuario {
  @PrimaryGeneratedColumn({ type: 'int', name: 'ID' })
  ID!: number;

  @Field((_type) => String)
  @Column({ type: 'varchar', length: 100, nullable: true })
  Nome: string | undefined;

  @Field((_type) => Number)
  @Column({ type: 'int', nullable: true })
  Idade!: number | undefined;

  @Field((_type) => [Playlist])
  @OneToMany(() => Playlist, playlist => playlist.usuario)
  playlists: Playlist[] | undefined;
}
