defmodule PortfolioDashboardWeb.Dashboard do
  use PortfolioDashboardWeb, :live_view

  def mount(_params, session, socket) do
    if session["user_email"] do
      {:ok, assign(socket, cryptos: "", stocks: "")}
    else
      {:halt, push_redirect(socket, to: "/auth/google")}
    end
  end

  def render(assigns) do
    ~H"""
     <div>
      <h1 class="text-2xl font-bold mb-4">📊 Portfolio Dashboard</h1>
      <h2 class="text-xl mb-2">Crypto Investments</h2>
      <%= for {coin, amount} <- @crypto do %>
        <p><%= coin %>: <%= amount %></p>
      <% end %>

      <h2 class="text-xl mt-6 mb-2">VN Index Stocks</h2>
      <%= for {stock, price} <- @stocks do %>
        <p><%= stock %>: <%= price %> VND</p>
      <% end %>
    </div>
    """
  end
end
