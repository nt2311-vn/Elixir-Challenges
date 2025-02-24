defmodule MyPortfolioWeb.AuthController do
  use MyPortfolioWeb, :controller
  plug(Ueberauth)

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assign: %{ueberauth_auth: auth}} = conn, _params) do
    case auth.info.email do
      "nguyentoan231196@gmail.com" ->
        conn
        |> put_session(:current_user, auth.info.email)
        |> put_flash(:info, "Welcome back #{auth.info.email}!")
        |> redirect(to: ~p"/dashboard")

      "bt.thuthao25@gmail.com" ->
        conn
        |> put_session(:current_user, auth.info.email)
        |> put_flash(:info, "Welcome back #{auth.info.email}!")
        |> redirect(to: ~p"/dashboard")

      _ ->
        conn |> put_flash(:error, "Unauthorized to access") |> redirect(to: "/")
    end
  end

  def delete(conn, _params) do
    conn |> configure_session(drop: true) |> redirect(to: "/")
  end
end
