defmodule AOC.Day11Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day11
  doctest Day11

  @simple "day11/simple_input.txt"
  @complex "day11/complex_input.txt"

  test "finds all monkeys from input" do
    assert 4 == Day11.get_monkeys(@simple) |> length

    # Just to make the test pass : - )
  end

  test "parses monkey parameters correctly" do
    [first_monkey, second_monkey, third_monkey, fourth_monkey] = Day11.get_monkeys(@simple)
    assert Map.get(first_monkey, :items) == [79, 98]
    assert Map.get(first_monkey, :test) == {23, 2, 3}

    first_operation = Map.get(first_monkey, :operation)
    assert first_operation.(10) == 190
    assert Map.get(second_monkey, :items) == [54, 65, 75, 74]
    assert Map.get(second_monkey, :test) == {19, 2, 0}
    second_operation = Map.get(second_monkey, :operation)
    assert second_operation.(134) == 140
    assert Map.get(third_monkey, :items) == [79, 60, 97]
    assert Map.get(third_monkey, :test) == {13, 1, 3}
    third_operation = Map.get(third_monkey, :operation)
    assert third_operation.(30) == 900
    assert Map.get(fourth_monkey, :items) == [74]
    assert Map.get(fourth_monkey, :test) == {17, 0, 1}
    fourth_operation = Map.get(fourth_monkey, :operation)
    assert fourth_operation.(10) == 13
  end

  test "monkey throws correctly" do
    monkeys =
      @simple
      |> Day11.get_monkeys()

    monkey_actions =
      monkeys
      |> Day11.perform_rounds(3)
      |> Enum.map(&Map.get(&1, :items))
      |> Enum.map(&Enum.sort/1)

    assert_lists_equal(monkey_actions, [[20, 23, 26, 27], [25, 167, 207, 401, 1046, 2080], [], []])
  end

  test "monkey throws correctly after 20 rounds" do
    [most_active, second_most_active | _who_cares] =
      @simple
      |> Day11.get_monkeys()
      |> Day11.perform_rounds(20, 3)
      |> Enum.map(fn %{:inspected_items => i} -> i end)
      |> Enum.sort()
      |> Enum.reverse()

    assert most_active * second_most_active == 10_605
  end

  test "monkey throws correctly after 1000 rounds with no stress factor" do
    [most_active, second_most_active | _who_cares] =
      @complex
      |> Day11.get_monkeys()
      |> Day11.perform_rounds(10_000, 1)
      |> Enum.map(fn %{:inspected_items => i} -> i end)
      |> Enum.sort()
      |> Enum.reverse()

    assert most_active * second_most_active == 15_050_382_231
  end
end
