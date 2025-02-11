defmodule PhoenixHelloApp.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_hello_app,
    adapter: Ecto.Adapters.Postgres
end
