import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, ManyToMany, JoinTable, JoinColumn } from 'typeorm';
import { Usuario } from './Usuario';
import { Musica } from './Musica';

@Entity('playlist', {synchronize: false})
export class Playlist {
  @PrimaryGeneratedColumn({ type: 'int', name: 'id' })
  ID!: number;

  @Column({ type: 'varchar', length: 100, nullable: true, name: 'nome' })
  Nome: string | undefined;

  @ManyToOne(() => Usuario, usuario => usuario.playlists, { nullable: false })
  @JoinColumn({ name: 'usuario_id' })
  usuario!: Usuario;

  @ManyToMany(() => Musica)
  @JoinTable()
  musicas: Musica[] | undefined;
}
