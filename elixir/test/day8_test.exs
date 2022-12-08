defmodule AOC.Day8Test do
  use ExUnit.Case
  alias AOC.Day8
  doctest Day8

  @simple "day8/simple_input.txt"
  @complex "day8/complex_input.txt"

  test "finds visible trees in complex" do
    assert 1776 ==
             @complex
             |> Day8.parse_trees()
             |> Day8.get_visible()
             |> length()
  end

  test "Finds visible trees in simple" do
    assert 21 ==
             @simple
             |> Day8.parse_trees()
             |> Day8.get_visible()
             |> length()
  end

  test "find sum of largest three in big text" do
  end
end
