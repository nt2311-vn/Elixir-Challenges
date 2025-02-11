defmodule ToyApp.Repo do
  use Ecto.Repo,
    otp_app: :toy_app,
    adapter: Ecto.Adapters.Postgres
end
