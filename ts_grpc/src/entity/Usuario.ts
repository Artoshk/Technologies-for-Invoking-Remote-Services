import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { Playlist } from './Playlist';

@Entity('Usuario', {synchronize: false})
export class Usuario {
  @PrimaryGeneratedColumn({ type: 'int', name: 'ID' })
  ID!: number;

  @Column({ type: 'varchar', length: 100, nullable: true })
  Nome: string | undefined;

  @Column({ type: 'int', nullable: true })
  Idade!: number | undefined;

  @OneToMany(() => Playlist, playlist => playlist.usuario)
  playlists: Playlist[] | undefined;
}
