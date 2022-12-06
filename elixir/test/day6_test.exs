defmodule AOC.Day6Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day6
  doctest Day6

  @simple "day6/simple_input.txt"
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
      assert Day6.get_marker(marker) == expected
    end
  end

  test "finds marker in complex input" do
    assert 1542 ==
             @complex
             |> Day6.read_marker()
             |> Day6.get_marker()
  end

  test "find sum of largest three in big text" do
  end
end
