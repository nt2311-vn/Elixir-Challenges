defmodule GuessingGameTest do
  use ExUnit.Case
  doctest GuessingGame

  test "greets the world" do
    assert GuessingGame.hello() == :world
  end
end
