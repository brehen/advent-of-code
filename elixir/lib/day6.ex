defmodule AOC.Day6 do
  import AOC.Utils, only: [read_input: 1]

  def get_gnomes(file_path) do
    read_input(file_path)
    |> String.split(~r/\n\n/, trim: true)
    |> Enum.map(&String.split(&1, ~r/\n/, trim: true))
    |> Enum.map(fn gnome -> Enum.map(gnome, &String.to_integer/1) end)
    |> Enum.map(&Enum.sum/1)
  end

  def get_highest(result) do
    result |> Enum.max()
  end

  def get_three_highest_sum(gnomes) do
    gnomes
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.slice(0..2)
    |> Enum.sum()
  end
end
