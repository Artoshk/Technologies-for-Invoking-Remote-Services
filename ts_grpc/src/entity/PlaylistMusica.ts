import { Entity, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Playlist } from './Playlist';
import { Musica } from './Musica';

@Entity('playlist_musica', {synchronize: false})
export class PlaylistMusica {
  @PrimaryGeneratedColumn({ type: 'int', name: 'id' })
  ID!: number;

  @ManyToOne(() => Playlist, playlist => playlist.ID)
  @JoinColumn({ name: 'playlist_id' })
  playlist: Playlist | undefined;

  @ManyToOne(() => Musica, musica => musica.ID)
  @JoinColumn({ name: 'musica_id' })
  musica: Musica | undefined;
}
