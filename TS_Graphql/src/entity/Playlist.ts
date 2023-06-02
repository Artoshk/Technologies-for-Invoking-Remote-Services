import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, ManyToMany, JoinTable, JoinColumn } from 'typeorm';
import { Usuario } from './Usuario';
import { Musica } from './Musica';
import { Field, ObjectType } from "type-graphql";

@ObjectType()
@Entity()
export class Playlist {
  @PrimaryGeneratedColumn({ type: 'int'})
  ID!: number;

  @Field((_type) => String)
  @Column({ type: 'varchar', length: 100, nullable: true })
  Nome: string | undefined;

  @Field((_type) => Usuario)
  @ManyToOne(() => Usuario, usuario => usuario.playlists, { nullable: false })
  @JoinColumn({ name: 'Usuario_ID' })
  usuario!: Usuario;

  @Field((_type) => [Musica])
  @ManyToMany(() => Musica)
  @JoinTable()
  musicas: Musica[] | undefined;
}
