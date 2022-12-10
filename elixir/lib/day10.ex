defmodule AOC.Day10 do
  import AOC.Utils, only: [read_input: 1]

  def get_instructions(file_path) do
    read_input(file_path)
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(&String.split(&1, ~r/\s/, trim: true))
    |> Enum.map(fn
      ["noop"] -> :noop
      ["addx", num] -> {:addx, String.to_integer(num)}
    end)
  end

  def do_instructions(instruction_list) do
    instruction_list
    |> do_instructions([1])
  end

  def do_instructions([], cycles), do: Enum.reverse(cycles)

  def do_instructions([instruction | instruction_list], [cycle | _] = cycles) do
    case instruction do
      :noop -> do_instructions(instruction_list, [cycle | cycles])
      {:addx, num} -> do_instructions(instruction_list, [cycle + num, cycle | cycles])
    end
  end

  def get_signal_strengths(cycles, indexes) do
    indexes
    |> Enum.map(&(Enum.at(cycles, &1 - 1) * &1))
    |> Enum.sum()
  end

  def draw_output(cycles) do
    Range.new(0, length(cycles) - 1)
    |> Enum.reduce([], fn
      pixel, acc when pixel == length(cycles) - 1 ->
        ["\n" | acc]

      pixel, acc ->
        curr_cycle = Enum.at(cycles, pixel)
        cycle_pos = Range.new(curr_cycle - 1, curr_cycle + 1)

        # add new line, in case we jumped to new row
        acc =
          if rem(pixel, 40) == 0 and pixel > 0,
            do: ["\n" | acc],
            else: acc

        if rem(pixel, 40) in cycle_pos do
          ["#" | acc]
        else
          ["." | acc]
        end
    end)
    |> Enum.reverse()
    |> Enum.join()
  end
end
