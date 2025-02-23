defmodule PortfolioDashboard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PortfolioDashboardWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:portfolio_dashboard, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PortfolioDashboard.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PortfolioDashboard.Finch},
      # Start a worker by calling: PortfolioDashboard.Worker.start_link(arg)
      # {PortfolioDashboard.Worker, arg},
      # Start to serve requests, typically the last entry
      PortfolioDashboardWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PortfolioDashboard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PortfolioDashboardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
