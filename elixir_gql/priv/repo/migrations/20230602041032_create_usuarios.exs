defmodule ElixirGql.Repo.Migrations.CreateUsuarios do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add :nome, :string
      add :idade, :integer

      timestamps()
    end
  end
end
