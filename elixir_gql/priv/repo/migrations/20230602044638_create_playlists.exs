defmodule ElixirGql.Repo.Migrations.CreatePlaylists do
  use Ecto.Migration

  def change do
    create table(:playlists) do
      add :nome, :string
      add :usuario_id, references(:usuarios, on_delete: :nothing)

      timestamps()
    end

    create index(:playlists, [:usuario_id])
  end
end
