defmodule AOC.Day3 do
  def read_input(file_path) do
    "../assets/#{file_path}"
    |> Path.expand(__DIR__)
    |> File.read!()
  end

  def split(list) do
    len = round(length(list) / 2)
    Enum.split(list, len)
  end

  def get_compartments(file_path) do
    read_input(file_path)
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(fn rucksack ->
      {left, right} =
        rucksack
        |> String.codepoints()
        |> split()

      [Enum.join(left), Enum.join(right)]
    end)
  end

  def get_common_item_type(rucksack) do
    rucksack
    |> Enum.map(fn [left, right] ->
      [common | _] = left
      |> String.codepoints()
      |> Enum.filter(&String.contains?(right, &1))
      common
    end)
  end

  def get_priority_value(item) do 
    [point] = String.to_charlist(item)

    case point do
      point when point > 96 -> point - 96
      point -> point - 38
    end
  end

end
