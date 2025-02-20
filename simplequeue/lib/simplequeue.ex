defmodule Simplequeue do
  use GenServer

  @doc """
  Start our queue and link it.
  This is a helper funciton
  """

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @doc """
  GenServer.init/1 callback
  """

  def init(state), do: {:ok, state}
end
