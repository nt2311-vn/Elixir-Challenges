defmodule StaticPage.Repo do
  use Ecto.Repo,
    otp_app: :static_page,
    adapter: Ecto.Adapters.Postgres
end
