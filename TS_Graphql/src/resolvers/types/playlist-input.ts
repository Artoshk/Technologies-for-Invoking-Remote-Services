import { InputType, Field, ID } from "type-graphql";

@InputType()
export class PlaylistMusicaInput {
    @Field((_type) => ID)
    ID!: number;
    
    @Field((_type) => ID)
    Playlist_ID!: number;
    
    @Field((_type) => ID)
    Musica_ID!: number;
    }