defmodule AOC.Day13Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day13
  doctest Day13

  @simple "day13/simple_input.txt"
  @complex "day13/complex_input.txt"

  test "Sums the correct amount per elf in simple input" do
    @complex
    |> Day13.get_packets()
    |> Enum.with_index(1)
    |> Enum.map(fn {pair, index} ->
      {left, right} = pair
      {index, Day13.order(left, right)}
    end)
    |> Enum.filter(fn {_, truthy} -> truthy end)
    |> Enum.map(fn {indx, _} -> indx end)
    |> Enum.sum()
    |> IO.inspect()
  end

  test "finds largest in big text" do
    @complex
    |> Day13.get_packet_pairs()
    |> Enum.reduce([], fn {left, right}, acc ->
      [left, right | acc]
    end)
    |> Enum.concat([[[2]], [[6]]])
    |> Enum.sort(fn left, right ->
      Day13.order(left, right)
    end)
    |> Enum.with_index(1)
    |> Enum.filter(fn {value, _} -> value in [[[2]], [[6]]] end)
    |> Enum.map(fn {_, index} -> index end)
    |> Enum.reduce(1, fn indx, acc -> indx * acc end)
    |> IO.inspect(charlists: :as_lists)
  end

  test "find sum of largest three in big text" do
  end
end
