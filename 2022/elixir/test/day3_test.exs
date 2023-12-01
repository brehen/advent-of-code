defmodule AOC.Day3Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day3
  doctest Day3

  @simple "day3/simple_input.txt"
  @complex "day3/complex_input.txt"

  test "splits up the rucksack correctly" do
    Day3.get_compartments(@simple)
    |> assert_lists_equal([
      ["vJrwpWtwJgWr", "hcsFMMfFFhFp"],
      ["jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"],
      ["PmmdzqPrV", "vPwwTWBwg"],
      ["wMqvLMZHhHMvwLH", "jbvcjnnSBnvTQFn"],
      ["ttgJtRGJ", "QctTZtZT"],
      ["CrZsJsPPZsGz", "wwsLwLmpwMDw"]
    ])
  end

  test "finds common item type" do
    @simple
    |> Day3.get_compartments()
    |> Day3.get_common_item_type()
    |> assert_lists_equal(["p", "L", "P", "v", "t", "s"])
  end

  test "priority values mapped correctly" do
    assert 157 ==
             ["p", "L", "P", "v", "t", "s"]
             |> Enum.map(&Day3.get_priority_value/1)
             |> Enum.sum()
  end

  test "finds sum from simple input" do
    assert 157 ==
             @simple
             |> Day3.get_compartments()
             |> Day3.get_common_item_type()
             |> Enum.map(&Day3.get_priority_value/1)
             |> Enum.sum()
  end

  test "find sum from complex input" do
    assert 7848 ==
             @complex
             |> Day3.get_compartments()
             |> Day3.get_common_item_type()
             |> Enum.map(&Day3.get_priority_value/1)
             |> Enum.sum()
  end

  # Part two

  test "determine common items and their points for each group" do
    assert 70 ==
             @simple
             |> Day3.get_rucksack_groups()
             |> Day3.get_common_item_type_across_group()
             |> Enum.map(&Day3.get_priority_value/1)
             |> Enum.sum()
  end

  test "determine common items and their points for each group in complex" do
    assert 2616 ==
             @complex
             |> Day3.get_rucksack_groups()
             |> Day3.get_common_item_type_across_group()
             |> Enum.map(&Day3.get_priority_value/1)
             |> Enum.sum()
  end
end
