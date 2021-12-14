defmodule ShipsTest do
  use ExUnit.Case
  doctest Ships

  test "greets the world" do
    assert Ships.hello() == :world
  end
end
