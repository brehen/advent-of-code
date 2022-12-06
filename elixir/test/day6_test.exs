defmodule AOC.Day6Test do
  use ExUnit.Case
  alias AOC.Day6
  doctest Day6

  @complex "day6/complex_input.txt"

  test "Finds marker correctly" do
    markers = [
      {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7},
      {"bvwbjplbgvbhsrlpgdmjqwftvncz", 5},
      {"nppdvjthqldpwncqszvftbrmjlhg", 6},
      {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10},
      {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11}
    ]

    for {marker, expected} <- markers do
      assert Day6.get_marker(marker, 4) == expected
    end
  end

  test "finds marker in complex input" do
    assert 1542 ==
             @complex
             |> Day6.read_marker()
             |> Day6.get_marker(4)
  end

  test "finds marker in compelex input with 14 length" do
    assert 3153 ==
             @complex
             |> Day6.read_marker()
             |> Day6.get_marker(14)
  end
end
