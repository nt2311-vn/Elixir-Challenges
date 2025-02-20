defmodule SimplequeueTest do
  use ExUnit.Case
  doctest Simplequeue

  test "greets the world" do
    assert Simplequeue.hello() == :world
  end
end
