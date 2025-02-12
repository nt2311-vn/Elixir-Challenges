defmodule StaticPageWeb.StaticPageControllerTest do
  use StaticPageWeb.ConnCase
  @base_title "Phoenix Tutorial Static Page"

  test "should get home page", %{conn: conn} do
    conn = get(conn, ~p"/static_pages/home")

    html_response(conn, 200) |> assert_select("title", "Home | #{@base_title}")
  end

  test "should get help page", %{conn: conn} do
    conn = get(conn, ~p"/static_pages/help")

    html_response(conn, 200) |> assert_select("title", "Help | #{@base_title}")
  end

  test "should get about page", %{conn: conn} do
    conn = get(conn, ~p"/static_pages/about")

    html_response(conn, 200) |> assert_select("title", "About | #{@base_title}")
  end
end
