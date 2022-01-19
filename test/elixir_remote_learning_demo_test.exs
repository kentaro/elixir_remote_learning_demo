defmodule ElixirRemoteLearningDemoTest do
  use ExUnit.Case
  doctest ElixirRemoteLearningDemo

  test "greets the world" do
    assert ElixirRemoteLearningDemo.hello() == :world
  end
end
