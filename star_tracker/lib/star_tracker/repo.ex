defmodule StarTracker.Repo do
  use Ecto.Repo,
    otp_app: :star_tracker,
    adapter: Ecto.Adapters.Postgres
end
