defmodule StaticPage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StaticPageWeb.Telemetry,
      StaticPage.Repo,
      {DNSCluster, query: Application.get_env(:static_page, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: StaticPage.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: StaticPage.Finch},
      # Start a worker by calling: StaticPage.Worker.start_link(arg)
      # {StaticPage.Worker, arg},
      # Start to serve requests, typically the last entry
      StaticPageWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StaticPage.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StaticPageWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
