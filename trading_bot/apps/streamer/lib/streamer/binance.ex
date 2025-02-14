defmodule Streamer.Binance do
  require Logger
  use WebSockex
  @stream_endpoint "wss://stream.binance.com:9443/ws/"

  def start_link(symbol) do
    symbol = String.downcase(symbol)

    WebSockex.start_link("#{@stream_endpoint}#{symbol}@trade", __MODULE__, %{})
  end

  def handle_frame({_type, msg}, state) do
    case Jason.decode(msg) do
      {:ok, event} -> process_event(event)
      {:error, _} -> Logger.error("Unable to parse msg: #{msg}")
    end

    {:ok, state}
  end

  def process_event(%{"e" => "trade"} = event) do
    trade_event = %Streamer.Binance.TradeEvent{
      :event_type => event["e"],
      :event_time => event["E"],
      :symbol => event["s"],
      :trade_id => event["t"],
      :price => event["p"],
      :quantity => event["q"],
      :buyer_order_id => event["b"],
      :seller_order_id => event["a"],
      :trade_time => event["T"],
      :buyer_market_maker => event["m"],
      :ignore => event["M"]
    }

    Logger.debug(
      "Trade event received " <>
        "#{trade_event.symbol} type:#{trade_event.event_type} price:@#{trade_event.price} vol:#{trade_event.quantity} market_maker:#{trade_event.buyer_market_maker}"
    )

    Phoenix.PubSub.broadcast(Streamer.PubSub, "TRADE_EVENTS:#{trade_event.symbol}", trade_event)
  end
end
