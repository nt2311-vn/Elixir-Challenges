defmodule Chat do
  def receive_message(msg) do
    IO.puts(msg)
  end

  def send_message(recipient, msg) do
    case recipient do
      :moebi@localhost ->
        spawn_task(__MODULE__, :receive_message_for_moebi, :moebi@localhost, [msg, Node.self()])

      _ ->
        spawn_task(__MODULE__, :receive_message, recipient, [msg])
    end
  end

  def receive_message_for_moebi(message, from) do
    IO.puts(message)
    send_message(from, "chicken?")
  end

  def spawn_task(module, fun, recipient, args) do
    recipient |> remote_supervisor() |> Task.Supervisor.async(module, fun, args) |> Task.await()
  end

  defp remote_supervisor(recipient) do
    {Chat.TaskSupervisor, recipient}
  end
end
