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

  test "finds three with highest scenic score" do
    assert 8 ==
             @simple
             |> Day8.parse_trees()
             |> Day8.get_scenic_scores()
             |> Enum.reduce([], fn score, acc -> [Enum.max(score) | acc] end)
             |> Enum.max()
  end

  test "finds three with highest scenic score in complex" do
    assert 234_416 ==
             @complex
             |> Day8.parse_trees()
             |> Day8.get_scenic_scores()
             |> Enum.reduce([], fn score, acc -> [Enum.max(score) | acc] end)
             |> Enum.max()
  end

  test "get score correctly for a tree" do
    score = Day8.get_score_of_tree(5, 1, 2, [2, 5, 5, 1, 2], [3, 5, 3, 5, 3])
    score2 = Day8.get_score_of_tree(5, 3, 2, [3, 3, 5, 4, 9], [3, 5, 3, 5, 3])
    score3 = Day8.get_score_of_tree(5, 2, 1, [6, 5, 3, 3, 2], [0, 5, 5, 3, 5])

    assert score == 4
    assert score2 == 8
    assert score3 == 6
  end
end
