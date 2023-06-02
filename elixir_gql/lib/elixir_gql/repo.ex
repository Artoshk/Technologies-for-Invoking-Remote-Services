defmodule ElixirGql.Repo do
  use Ecto.Repo,
    otp_app: :elixir_gql,
    adapter: Ecto.Adapters.Postgres
end
