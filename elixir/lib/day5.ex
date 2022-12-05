defmodule AOC.Day5 do
  import AOC.Utils, only: [read_input: 1]

  def get_input_parts(file_path) do
    read_input(file_path)
    |> String.split(~r/\n\n/, trim: true)
  end

  def parse_crane(crane) do
    crane
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(fn line ->
      line =
        line
        |> String.split("", trim: true)

      Enum.drop_every(["" | line], 4)
      |> Enum.chunk_every(3)
      |> Enum.map(fn [_, two, _] -> two end)
    end)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.filter(&1, fn c -> c != " " end))
    |> Enum.map(&Enum.drop(&1, -1))
  end

  def parse_movements(moves) do
    moves
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(~r/\s/, trim: true)
      |> Enum.drop_every(2)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def parse_input_parts([crane, moves]),
    do: {
      parse_crane(crane),
      parse_movements(moves)
    }

  def perform_move({crane, [0, _from, _to]}) do
    crane
  end

  def perform_move({crane, [move, from, to]}) do
    [from_at | new_from] = Enum.at(crane, from - 1)
    to_at = Enum.at(crane, to - 1)
    new_to = [from_at | to_at]

    crane =
      crane
      |> Enum.with_index(1)
      |> Enum.map(fn
        {_, ^from} -> new_from
        {_, ^to} -> new_to
        {x, _} -> x
      end)

    perform_move({crane, [move - 1, from, to]})
  end

  def perform_moves({crane, []}), do: crane

  def perform_moves({crane, [move | moves]}) do
    crane = perform_move({crane, move})
    perform_moves({crane, moves})
  end
end
