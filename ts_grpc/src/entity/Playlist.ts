import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, ManyToMany, JoinTable, JoinColumn } from 'typeorm';
import { Usuario } from './Usuario';
import { Musica } from './Musica';

@Entity()
export class Playlist {
  @PrimaryGeneratedColumn({ type: 'int'})
  ID!: number;

  @Column({ type: 'varchar', length: 100, nullable: true })
  Nome: string | undefined;

  @ManyToOne(() => Usuario, usuario => usuario.playlists, { nullable: false })
  @JoinColumn({ name: 'Usuario_ID' })
  usuario!: Usuario;

  @ManyToMany(() => Musica)
  @JoinTable()
  musicas: Musica[] | undefined;
}
