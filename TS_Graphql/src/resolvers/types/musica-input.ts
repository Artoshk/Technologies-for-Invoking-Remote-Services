import { InputType, Field, ID } from "type-graphql";

@InputType()
export class MusicaInput {
    @Field((_type) => ID)
    ID!: number;
    
    @Field((_type) => String)
    Nome: string | undefined;
    
    @Field((_type) => String)
    Artista: string | undefined;
    }