defmodule AOC.Day13 do
  import AOC.Utils, only: [read_input: 1]

  def get_packets_pairs(file_path) do
    read_input(file_path)
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn pair ->
      [a, b] = pair |> String.split("\n", trim: true)

      {a, _} = Code.eval_string(a)
      {b, _} = Code.eval_string(b)

      {a, b}
    end)
  end

  def order([], []), do: nil
  def order([_ | _], []), do: false
  def order([], [_ | _]), do: true

  def order([left | left_rest], [right | right_rest])
      when is_integer(left) and is_integer(right) do
    cond do
      left < right -> true
      left > right -> false
      left == right -> order(left_rest, right_rest)
    end
  end

  def order([left | left_rest], [right | right_rest]) when is_list(left) and is_list(right) do
    case order(left, right) do
      nil -> order(left_rest, right_rest)
      result -> result
    end
  end

  def order([left | left_rest], [right | right_rest]) when is_list(left) and is_integer(right) do
    order([left | left_rest], [[right] | right_rest])
  end

  def order([left | left_rest], [right | right_rest]) when is_integer(left) and is_list(right) do
    order([[left] | left_rest], [right | right_rest])
  end
end
