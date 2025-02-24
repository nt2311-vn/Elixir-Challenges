defmodule MyPortfolioWeb.Router do
  use MyPortfolioWeb, :router
  alias MyPortfolioWeb.DashboardLive
  alias MyPortfolioWeb.AuthController

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {MyPortfolioWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :require_authenticated_user do
    plug(:put_user_token)
    plug(:ensure_authenticated)
  end

  defp ensure_authenticated(conn, _opts) do
    if get_session(conn, :current_user) do
      conn
    else
      conn
      |> put_flash(:error, "You must be log in to access this page")
      |> redirect(to: "/auth/google")
      |> halt()
    end
  end

  defp put_user_token(conn, _opts) do
    if current_user = get_session(conn, :current_user) do
      token = Phoenix.Token.sign(conn, "user socket", current_user)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  scope "/", MyPortfolioWeb do
    pipe_through([:browser, :require_authenticated_user])

    get("/", PageController, :home)
    live("/dashboard", DashboardLive)
  end

  scope "/auth", MyPortfolioWeb do
    pipe_through(:browser)

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
    post("/:provider/callback", AuthController, :callback)
    delete("/logout", AuthController, :delete)
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyPortfolioWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:my_portfolio, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: MyPortfolioWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
