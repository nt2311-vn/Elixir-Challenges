defmodule Streamer do
  def start_streaming(symbol) do
    Streamer.Binance.start_link(symbol)
  end
end
