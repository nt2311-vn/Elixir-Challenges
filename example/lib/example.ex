defmodule Example do
  def add(a, b) do
    IO.puts(a + b)
  end

  def listen() do
    receive do
      {:ok, "hello"} ->
        IO.puts("world")
    end

    listen()
  end

  def explode(), do: exit("kaboom !!!")

  def run do
    # Process.flag(:trap_exit, true)
    # spawn_link(Example, :explode, [])
    #
    # receive do
    #   {:EXIT, _from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    # end

    spawn_monitor(Example, :explode, [])

    receive do
      {:DOWN, _ref, :process, _from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end

  def double(x) do
    :timer.sleep(10000)
    x * 2
  end
end
