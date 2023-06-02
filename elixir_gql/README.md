# ElixirGql

## About
ElixirGql is a Phoenix application that provides a GraphQL API for a music streaming service.

## Getting Started
Before starting, there are some limitation about Phoenix and MySQL, so we are using PostgreSQL instead.
First you will need to start the container with the following command:
```
cd docker/pg
docker-compose up -d
```

Then you will need to create the database and run the migrations:
```
mix deps.get
mix ecto.create
mix ecto.migrate
```

Then you can start the Phoenix endpoint by running one of the following commands:
    - `mix phx.server`
    - If you prefer running it inside IEx (Interactive Elixir), use the command:
      ```
      iex -S mix phx.server
      ```

Now you can visit [`localhost:4000/graphiql`](http://localhost:4000/graphiql) from your browser to access the GraphQL API.

## Deployment
If you're ready to run the application in a production environment, please check our deployment guides in the [Phoenix documentation](https://hexdocs.pm/phoenix/deployment.html).