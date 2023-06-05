import { Entity, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Playlist } from './Playlist';
import { Musica } from './Musica';

@Entity()
export class PlaylistMusica {
  @PrimaryGeneratedColumn({ type: 'int' })
  ID!: number;

  @ManyToOne(() => Playlist, playlist => playlist.ID)
  @JoinColumn({ name: 'Playlist_ID' })
  playlist: Playlist | undefined;

  @ManyToOne(() => Musica, musica => musica.ID)
  @JoinColumn({ name: 'Musica_ID' })
  musica: Musica | undefined;
}
