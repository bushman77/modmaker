defmodule CoreFunctionsTest do
  use ExUnit.Case
  doctest CoreFunctions

  test "greets the world" do
    assert CoreFunctions.hello() == :world
  end
end
