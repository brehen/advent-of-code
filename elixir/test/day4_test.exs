defmodule AOC.Day4Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day4
  doctest Day4

  @simple "day4/simple_input.txt"
  @complex "day4/complex_input.txt"


  test "splits input correctly" do
    [first_pair, second_pair | _] = 
      @simple
      |> Day4.get_assignments

    assert_lists_equal(first_pair, [2..4, 6..8])
    assert_lists_equal(second_pair, [2..3, 4..5])
  end

  test "able to determine if one range fully contains the other" do
    assert 2 == 
      @simple
      |> Day4.get_assignments
      |> Day4.get_range_in_other
      |> length
  end


  test "finds right amount of ranges in others in complex" do
    assert 567 == 
      @complex
      |> Day4.get_assignments
      |> Day4.get_range_in_other
      |> length
  end
end
