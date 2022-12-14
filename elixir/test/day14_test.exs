defmodule AOC.Day14Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day14
  doctest Day14

  @simple "day14/simple_input.txt"
  @complex "day14/complex_input.txt"

  test "Maps out cave correctly" do
    {cave, edges} =
      @simple
      |> Day14.get_cave()

    assert length(Map.keys(cave)) == 100

    assert Day14.draw_cave(cave, edges) ==
             "......+...
..........
..........
..........
....#...##
....#...#.
..###...#.
........#.
........#.
#########."
  end

  test "drops sand correctly" do
    {cave, edges} =
      @complex
      |> Day14.get_cave()

    # assert Day14.draw_cave(cave, edges) ==
    "......+...
..........
..........
..........
....#...##
....#...#.
..###...#.
........#.
......o.#.
#########."
  end

  test "works for large set as well" do
    @complex
    |> Day14.parse_input()
    |> Day14.part2()
    |> IO.inspect()

    # IO.puts(drawn_cave)
  end

  test "find sum of largest three in big text" do
  end
end
