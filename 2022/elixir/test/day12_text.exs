defmodule AOC.Day12Test do
  use ExUnit.Case
  #  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day12
  doctest Day12

  @simple "day12/simple_input.txt"
  @complex "day12/complex_input.txt"

  @tag :skip
  test "finds shortest path in simple" do
    assert 31 ==
             @simple
             |> Day12.get_grid()
             |> Day12.get_shortest_path()
  end

  @tag :skip
  test "finds start and end for simple" do
    start_and_end = @simple |> Day12.get_grid() |> Day12.find_start_and_end()
    assert start_and_end == {{?a, {0, 0}}, {?z, {2, 5}}}
  end

  @tag :skip
  test "finds start and end for complex" do
    start_and_end = @complex |> Day12.get_grid() |> Day12.find_start_and_end()
    assert start_and_end == {{?a, {20, 0}}, {?z, {20, 145}}}
  end

  @tag :skip
  test "finds available steps" do
    grid = @simple |> Day12.get_grid()
    {start, _end} = grid |> Day12.find_start_and_end()
    assert Day12.get_available_next_steps(grid, start) == [:D, :R]
  end

  test "works" do
    {goal, start, edges} = @complex |> Day12.get_input() |> Day12.prepare_map()

    distances = Day12.distances(goal, Day12.reverse_edges(edges))
  end
end
