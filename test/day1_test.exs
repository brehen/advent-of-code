defmodule Day1Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  doctest Day1

  test "Sums the correct amount per elf in simple input" do
    expected_results = [6000, 4000, 11_000, 24_000, 10_000]
    actual_results = Day1.get_result("simple_input.txt")
    assert_lists_equal(actual_results, expected_results)
    highest = Day1.get_highest(actual_results)
    assert highest === 24_000
  end

  test "finds largest in big text" do
    sum =
      Day1.get_result("complex_input.txt")
      |> Enum.sort()
      |> Enum.reverse()
      |> Enum.slice(0..2)
      |> Enum.sum()

    # Just to make the test pass : - )
    assert sum == 200_945
  end
end
