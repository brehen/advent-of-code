defmodule AOC.Day2Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day2
  doctest Day2

  @simple "day2/simple_input.txt"
  @complex "day2/complex_input.txt"

  test "interprets simple input correctly" do
    Day2.get_rounds(@simple)
    |> Day2.get_mapped_rounds_1()
    |> assert_lists_equal([["rock", "paper"], ["paper", "rock"], ["scissors", "scissors"]])
  end

  # score == outcome + chosen move
  test "finds opposing moves correctly" do
    score1 =
      ["A", "Y"]
      |> Day2.get_mapped_moves()
      |> Day2.get_score_from_round()

    assert score1 == 6 + 2

    score2 =
      ["B", "X"]
      |> Day2.get_mapped_moves()
      |> Day2.get_score_from_round()

    assert score2 == 0 + 1

    score3 =
      ["C", "Z"]
      |> Day2.get_mapped_moves()
      |> Day2.get_score_from_round()

    assert score3 == 3 + 3

    score4 =
      ["B", "Z"]
      |> Day2.get_mapped_moves()
      |> Day2.get_score_from_round()

    assert score4 == 6 + 3

    score5 =
      ["A", "X"]
      |> Day2.get_mapped_moves()
      |> Day2.get_score_from_round()

    assert score5 == 3 + 1

    score6 =
      ["B", "Y"]
      |> Day2.get_mapped_moves()
      |> Day2.get_score_from_round()

    assert score6 == 3 + 2
  end

  test "Outcome of round gives correct score" do
    rounds =
      Day2.get_rounds(@simple)
      |> Day2.get_mapped_rounds_1()
      |> Enum.map(&Day2.get_score_from_round/1)
      |> Enum.sum()

    assert rounds == 15
  end

  test "returns correct for larger set as well" do
    rounds =
      Day2.get_rounds(@complex)
      |> Day2.get_mapped_rounds_1()
      |> Enum.map(&Day2.get_score_from_round/1)
      |> Enum.sum()

    assert rounds == 13268
  end

  test "but there was a twist" do
    rounds =
      Day2.get_rounds(@complex)
      |> Day2.get_mapped_rounds_2()
      |> Enum.map(&Day2.get_score_from_round/1)
      |> Enum.sum()

    assert rounds == 15508
  end
end
