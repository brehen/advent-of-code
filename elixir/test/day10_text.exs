defmodule AOC.Day10Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day10
  doctest Day10

  @simple "day10/simple_input.txt"
  @complex "day10/complex_input.txt"

  test "parses instructions correctly" do
    assert 146 ==
             @simple
             |> Day10.get_instructions()
             |> length()
  end

  test "performs correct amount of cycles based on input" do
    [:noop, {:addx, 3}, {:addx, -5}]
    |> Day10.do_instructions()
    |> assert_lists_equal([-1, 4, 4, 1, 1, 1])

    assert 241 ==
             @simple
             |> Day10.get_instructions()
             |> Day10.do_instructions()
             |> Enum.reverse()
             |> length()
  end

  test "finds correct value at registers" do
    expected = [{20, 21}, {60, 19}, {100, 18}, {140, 21}, {180, 16}, {220, 18}]

    cycles =
      @simple
      |> Day10.get_instructions()
      |> Day10.do_instructions()

    for {index, expected} <- expected do
      assert(expected == Enum.at(cycles, index - 1))
    end
  end

  test "finds correct signal strengths at each index" do
    assert 13_140 ==
             @simple
             |> Day10.get_instructions()
             |> Day10.do_instructions()
             |> Day10.get_signal_strengths([20, 60, 100, 140, 180, 220])
  end

  test "finds correct signal strengths at each index for complex input" do
    assert 14_820 ==
             @complex
             |> Day10.get_instructions()
             |> Day10.do_instructions()
             |> Day10.get_signal_strengths([20, 60, 100, 140, 180, 220])
  end

  test "draws correctly" do
    expected_output = """
    ##..##..##..##..##..##..##..##..##..##..
    ###...###...###...###...###...###...###.
    ####....####....####....####....####....
    #####.....#####.....#####.....#####.....
    ######......######......######......####
    #######.......#######.......#######.....
    """

    simple =
      @simple
      |> Day10.get_instructions()
      |> Day10.do_instructions()
      |> Day10.draw_output()

    assert simple == expected_output

    complex =
      @complex
      |> Day10.get_instructions()
      |> Day10.do_instructions()
      |> Day10.draw_output()

    expected_complex = """
    ###..####.####.#..#.####.####.#..#..##..
    #..#....#.#....#.#..#....#....#..#.#..#.
    #..#...#..###..##...###..###..####.#..#.
    ###...#...#....#.#..#....#....#..#.####.
    #.#..#....#....#.#..#....#....#..#.#..#.
    #..#.####.####.#..#.####.#....#..#.#..#.
    """

    assert expected_complex == complex
  end
end
