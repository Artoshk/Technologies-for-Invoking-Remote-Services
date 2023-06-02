defmodule ElixirGql.Repo.Migrations.CreateMusicas do
  use Ecto.Migration

  def change do
    create table(:musicas) do
      add :nome, :string
      add :artista, :string

      timestamps()
    end
  end
end
