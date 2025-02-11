defmodule PhoenixHelloAppWeb.PageController do
  use PhoenixHelloAppWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def hello(conn, _params) do
    html(conn, "¡Chao!")
  end

  def goodbye(conn, _params) do
    html(conn, "goodbye, world!")
  end
end
