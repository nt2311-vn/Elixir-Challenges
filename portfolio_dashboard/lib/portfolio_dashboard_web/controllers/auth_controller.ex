defmodule PortfolioDashboardWeb.AuthController do
  use PortfolioDashboardWeb, :controller
  plug(Ueberauth)

  @allowed_emails ["nguyentoan231196@gmail.com", "bt.thuthao25@gmail.com"]

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    email = auth.info.email

    if email in @allowed_emails do
      conn
      |> put_session(:user_email, email)
      |> configure_session(renew: true)
      |> put_flash(:info, "Welcome back, #{email}!")
      |> redirect(to: ~p"/dashboard")
    else
      conn
      |> put_flash(:error, "Unauthorized to access.")
      |> redirect(to: ~p"/")
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "Sign out successfully.")
    |> redirect(to: ~p"/")
  end
end
