defmodule AOC.Day11 do
  import AOC.Utils, only: [read_input: 1]

  @manage_stress 17 * 5 * 11 * 13 * 3 * 19 * 2 * 7
  # @manage_stress 23 * 19 * 13 * 17

  @type monkey :: %{
          :items => [integer()],
          :operation => any(),
          :test => {integer(), integer(), integer()},
          :position => integer(),
          :inspected_items => integer()
        }

  defp monkey_reducer("Monkey", acc), do: acc

  defp monkey_reducer("Starting items: " <> items, acc) do
    parsed_items =
      items
      |> String.split(", ", trim: true)
      |> Enum.map(&String.to_integer/1)

    Map.put(acc, :items, parsed_items)
  end

  defp monkey_reducer("Operation: new = old * old", acc),
    do: Map.put(acc, :operation, &(&1 * &1))

  defp monkey_reducer("Operation: new = " <> operation, acc) do
    [_old, sign, add] = String.split(operation, " ")

    add = String.to_integer(add)

    operation_func =
      case sign do
        "*" -> &(&1 * add)
        "+" -> &(&1 + add)
        "-" -> &(&1 - add)
      end

    Map.put(acc, :operation, operation_func)
  end

  defp monkey_reducer("Test: divisible by " <> divisible_by, acc),
    do: Map.put(acc, :test, {String.to_integer(divisible_by)})

  defp monkey_reducer("If true: throw to monkey " <> target, acc) do
    {div_by} = Map.get(acc, :test)
    test = {div_by, String.to_integer(target)}
    Map.put(acc, :test, test)
  end

  defp monkey_reducer("If false: throw to monkey " <> target, acc) do
    {div_by, if_true} = Map.get(acc, :test)
    test = {div_by, if_true, String.to_integer(target)}
    Map.put(acc, :test, test)
  end

  defp monkey_reducer(_, acc), do: acc

  def get_monkeys(file_path) do
    read_input(file_path)
    |> String.split(~r/\n\n/, trim: true)
    |> Enum.map(fn monkey ->
      monkey
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.reduce(%{}, &monkey_reducer/2)
    end)
    |> Enum.with_index()
    |> Enum.map(fn {monkey, index} ->
      monkey = Map.put(monkey, :position, index)
      Map.put(monkey, :inspected_items, 0)
    end)
  end

  def perform_rounds(monkeys, manage_stress) do
    monkeys
    |> perform_round(manage_stress)
  end

  def perform_rounds(monkeys, 1, manage_stress) do
    perform_rounds(monkeys, manage_stress)
  end

  def perform_rounds(monkeys, rounds, manage_stress) do
    monkeys
    |> perform_round(manage_stress)
    |> perform_rounds(rounds - 1, manage_stress)
  end

  def perform_round(monkeys, manage_stress \\ 3) do
    monkeys
    |> Enum.reduce(monkeys, &perform_round(&1, &2, manage_stress))
  end

  def perform_round(monkey, monkeys, manage_stress) do
    position = Map.get(monkey, :position)
    items = Enum.at(monkeys, position) |> Map.get(:items)
    inspected_items = Map.get(monkey, :inspected_items)
    operation = Map.get(monkey, :operation)
    {div_by, target_if_true, target_if_false} = Map.get(monkey, :test)

    manage_stress = if manage_stress == 3, do: 3, else: @manage_stress

    new_items =
      items
      |> Enum.map(fn item ->
        # Monkey is crazy
        new_item_worry = operation.(item)

        new_item_worry =
          if manage_stress == 3,
            do: div(new_item_worry, 3),
            else:
              rem(new_item_worry, manage_stress)
              |> floor()

        new_item_passes_test = rem(new_item_worry, div_by) == 0

        target = if new_item_passes_test, do: target_if_true, else: target_if_false
        {new_item_worry, target}
      end)

    monkey = Map.put(monkey, :inspected_items, inspected_items + length(items))
    current_monkey_after = Map.put(monkey, :items, [])

    Enum.reduce(new_items, monkeys, fn {new_item, target}, acc ->
      target_monkey = Enum.at(acc, target)
      target_monkey_items = Map.get(target_monkey, :items)

      new_monkey = Map.put(target_monkey, :items, [new_item | target_monkey_items])

      List.replace_at(acc, target, new_monkey)
    end)
    |> List.replace_at(position, current_monkey_after)
  end

  def get_three_highest_sum(gnomes) do
    gnomes
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.slice(0..2)
    |> Enum.sum()
  end
end
