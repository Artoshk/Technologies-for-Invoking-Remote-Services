import { Resolver, FieldResolver, Root } from "type-graphql";
import { Service } from "typedi";

import { Musica } from "../entity/Musica";

@Service()
@Resolver((_of) => Musica)
export class MusicaResolver {
  constructor(
  ) {}

  @FieldResolver((_type) => String)
  async Nome(@Root() musica: Musica) {
    return musica.Nome;
  }

  @FieldResolver((_type) => String)
  async Artista(@Root() musica: Musica) {
    return musica.Artista;
  }
}