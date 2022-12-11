defmodule AOC.Day11Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day11
  doctest Day11

  @simple "day11/simple_input.txt"
  @complex "day11/complex_input.txt"

  test "Sums the correct amount per elf in simple input" do
  end

  test "finds all monkeys from input" do
    assert 4 == Day11.get_monkeys(@simple) |> length

    # Just to make the test pass : - )
  end

  test "parses monkey parameters correctly" do
    [first_monkey, second_monkey, third_monkey, fourth_monkey] = Day11.get_monkeys(@simple)
    assert Map.get(first_monkey, :items) == {79, 98}
    assert Map.get(first_monkey, :test) == {23, 2, 3}

    first_operation = Map.get(first_monkey, :operation)
    assert first_operation.(10) == 190
    IO.inspect(first_operation.(10))
    assert Map.get(second_monkey, :items) == {54, 65, 75, 74}
    assert Map.get(second_monkey, :test) == {19, 2, 0}
    assert Map.get(third_monkey, :items) == {79, 60, 97}
    assert Map.get(third_monkey, :test) == {13, 1, 3}
    assert Map.get(fourth_monkey, :items) == {74}
    assert Map.get(fourth_monkey, :test) == {17, 0, 1}
  end
end
