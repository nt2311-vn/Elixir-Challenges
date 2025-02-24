defmodule MyPortfolioWeb.DashboardLive do
  use MyPortfolioWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    crypto = 0
    stocks = 0
    socket = socket |> assign(:crypto, crypto) |> assign(stocks, stocks)

    {:ok, socket}
  end
end
