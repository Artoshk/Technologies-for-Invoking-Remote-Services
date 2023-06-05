import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { Playlist } from './Playlist';

@Entity('usuario', {synchronize: false})
export class Usuario {
  @PrimaryGeneratedColumn({ type: 'int', name: 'id' })
  ID!: number;

  @Column({ type: 'varchar', length: 100, nullable: true, name: 'nome' })
  Nome: string | undefined;

  @Column({ type: 'int', nullable: true, name: 'idade' })
  Idade!: number | undefined;

  @OneToMany(() => Playlist, playlist => playlist.usuario)
  playlists: Playlist[] | undefined;
}
