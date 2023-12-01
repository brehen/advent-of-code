defmodule AOC.Day4 do
  import AOC.Utils, only: [read_input: 1]

  defp pair_to_range([a, b]) do
    Range.new(String.to_integer(a), String.to_integer(b))
  end

  def get_assignments(file_path) do
    file_path
    |> read_input()
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(~r/,/, trim: true)
      |> Enum.map(&String.split(&1, "-", trim: true))
      |> Enum.map(&pair_to_range/1)
    end)
  end

  def get_range_in_other(result) do
    result
    |> Enum.filter(fn [a1..a2, b1..b2] ->
      cond do
        a1 >= b1 and a2 <= b2 -> true
        b1 >= a1 and b2 <= a2 -> true
        true -> false
      end
    end)
  end

  def get_range_in_other_at_all(result) do
    result
    |> Enum.filter(fn [a1..a2, b1..b2] ->
      !(a2 < b1 or a1 > b2)
    end)
  end
end
