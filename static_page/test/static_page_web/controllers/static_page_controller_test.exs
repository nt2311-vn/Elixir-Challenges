defmodule StaticPageWeb.StaticPageControllerTest do
  use StaticPageWeb.ConnCase

  test "should get home page", %{conn: conn} do
    conn = get(conn, ~p"/static_pages/home")

    assert html_response(conn, 200)
  end

  test "should get help page", %{conn: conn} do
    conn = get(conn, ~p"/static_pages/help")

    assert html_response(conn, 200)
  end

  test "should get about page", %{conn: conn} do
    conn = get(conn, ~p"/static_pages/about")

    assert html_response(conn, 200)
  end
end
