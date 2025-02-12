defmodule StaticPageWeb.PageControllerTest do
  use StaticPageWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end

  test "GET /hello", %{conn: conn} do
    conn = get(conn, ~p"/hello")
    assert html_response(conn, 200) =~ "hello, world!"
  end
end
