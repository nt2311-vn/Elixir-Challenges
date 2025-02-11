defmodule WebSocketExample do
  use WebSockex

  def start_link(url, state) do
    WebSockex.start_link(url, __MODULE__, state)
  end

  def handle_frame({type, msg}, state) do
    IO.puts("Received Message - Type #{inspect(type)} -- Message: #{inspect(msg)}")
    {:ok, state}
  end
end
