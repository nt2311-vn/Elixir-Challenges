defmodule StaticPageWeb.Router do
  use StaticPageWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", StaticPageWeb do
    pipe_through(:browser)

    get("/", PageController, :home)
    get("/hello", PageController, :hello)

    get("/static_pages/home", StaticPageController, :home)
    get("/static_pages/help", StaticPageController, :help)
    get("/static_pages/about", StaticPageController, :about)
  end

  # Other scopes may use custom stacks.
  # scope "/api", StaticPageWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:static_page, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: StaticPageWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
