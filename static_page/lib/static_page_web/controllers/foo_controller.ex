defmodule StaticPageWeb.FooController do
  use StaticPageWeb, :controller

  def bar(conn, _params) do
    render(conn, "bar.html")
  end

  def baz(conn, _params) do
    render(conn, "baz.html")
  end
end
