defmodule MyPortfolio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MyPortfolioWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:my_portfolio, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MyPortfolio.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MyPortfolio.Finch},
      # Start a worker by calling: MyPortfolio.Worker.start_link(arg)
      # {MyPortfolio.Worker, arg},
      # Start to serve requests, typically the last entry
      MyPortfolioWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyPortfolio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MyPortfolioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
