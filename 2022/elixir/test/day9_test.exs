defmodule AOC.Day9Test do
  use ExUnit.Case
  alias AOC.Day9
  doctest Day9

  @complex "day9/complex_input.txt"

  test "Moves around correctly and tail follows" do
    assert 6269 ==
             @complex
             |> Day9.get_moves()
             |> Day9.do_all_moves()
             |> Day9.determine_tail_path()
             |> Day9.get_touched_points()
  end

  test "asserts head and tail bounds correctly" do
    h1 = {0, 0}
    t1 = {0, 0}

    h2 = {1, 0}
    t2 = {0, 0}

    h3 = {2, 0}
    t3 = {0, 0}

    h4 = {3, 0}
    t4 = {1, 0}

    h5 = {3, 1}
    t5 = {2, 0}

    assert Day9.is_within_bounds(h1, t1)
    assert Day9.is_within_bounds(h2, t2)
    assert Day9.is_within_bounds(h3, t3) == false
    assert Day9.is_within_bounds(h4, t4) == false
    assert Day9.is_within_bounds(h5, t5)
  end

  test "tail follows all the way, even for large ropes" do
    head =
      @complex
      |> Day9.get_moves()
      |> Day9.do_all_moves()

    tail =
      0..8
      |> Enum.reduce(head, fn _, acc -> acc |> Day9.determine_tail_path() end)
      |> Day9.get_touched_points()

    assert tail == 2557
  end
end
