defmodule Streamer.Binance do
  use WebSockex
  @stream_endpoint "wss://stream.binance.com:9443/ws/"

  def start_link(symbol) do
    symbol = String.downcase(symbol)

    WebSockex.start_link("#{@stream_endpoint}#{symbol}@trade", __MODULE__, %{})
  end

  def handle_frame({type, msg}, state) do
    IO.puts("Received message - Type: #{inspect(type)} -- Message: #{inspect(msg)}")
    {:ok, state}
  end
end
