defmodule AOC.Day11 do
  import AOC.Utils, only: [read_input: 1]

  @type monkey :: %{
          :items => [integer()],
          :operation => any(),
          :test => {integer(), integer(), integer()}
        }

  def get_monkeys(file_path) do
    read_input(file_path)
    |> String.split(~r/\n\n/, trim: true)
    |> Enum.map(fn monkey ->
      monkey
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.reduce(%{}, fn
        "Monkey" <> _, acc ->
          acc

        "Starting items: " <> items, acc ->
          parsed_items =
            items
            |> String.split(", ", trim: true)
            |> Enum.map(&String.to_integer/1)
            |> List.to_tuple()

          Map.put(acc, :items, parsed_items)

        "Operation: new = old * old", acc ->
          Map.put(acc, :test, &(&1 * &1))

        "Operation: new = " <> operation, acc ->
          [_old, sign, add] = String.split(operation, " ")

          add = String.to_integer(add)

          operation_func =
            case sign do
              "*" -> &(&1 * add)
              "+" -> &(&1 + add)
              "-" -> &(&1 - add)
            end

          Map.put(acc, :operation, operation_func)

        "Test: divisible by " <> divisible_by, acc ->
          Map.put(acc, :test, {String.to_integer(divisible_by)})

        "If true: throw to monkey " <> target, acc ->
          {div_by} = Map.get(acc, :test)
          test = {div_by, String.to_integer(target)}
          Map.put(acc, :test, test)

        "If false: throw to monkey " <> target, acc ->
          {div_by, if_true} = Map.get(acc, :test)
          test = {div_by, if_true, String.to_integer(target)}
          Map.put(acc, :test, test)

        _, acc ->
          acc
      end)
    end)
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
