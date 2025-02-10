defmodule GuessingGame do
  def start do
    IO.puts("From 1 to 100 please guess a number\n")
    answer = Enum.random(1..100)
    guess(answer)
  end

  def guess(answer) do
    input = IO.gets("> ")

    case input |> String.trim() |> Integer.parse() do
      :error ->
        IO.puts("Please enter a proper nunber\n")
        guess(answer)

      {number, _} when number < 1 or number > 100 ->
        IO.puts("Please enter in the range of 1 upto 100\n")
        guess(answer)

      {number, _} when number > answer ->
        IO.puts("Ah ah.. too high\n")
        guess(answer)

      {number, _} when number < answer ->
        IO.puts("Ah ah... too low\n")
        guess(answer)

      _ ->
        IO.puts("You are correct #{answer}\n")
    end
  end
end
