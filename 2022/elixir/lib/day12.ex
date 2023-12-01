defmodule AOC.Day12 do
  import AOC.Utils, only: [read_input: 1]

  def run do
    {heights, start_position, end_position} =
      "../assets/day12/complex_input.txt"
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> Enum.with_index()
      |> Enum.reduce({%{}, nil, nil}, fn {line, row_index}, {acc, start_position, end_position} ->
        line =
          line
          |> String.trim()
          |> String.to_charlist()

        heights =
          line
          |> Enum.with_index()
          |> Enum.map(fn
            {letter, column_index} when letter in ?a..?z ->
              {{row_index, column_index}, letter - ?a}

            {?S, column_index} ->
              {{row_index, column_index}, 0}

            {?E, column_index} ->
              {{row_index, column_index}, 25}
          end)

        start_position =
          case Enum.find_index(line, &(&1 == ?S)) do
            nil -> start_position
            column_index -> {row_index, column_index}
          end

        end_position =
          case Enum.find_index(line, &(&1 == ?E)) do
            nil -> end_position
            column_index -> {row_index, column_index}
          end

        {Map.merge(acc, Map.new(heights)), start_position, end_position}
      end)

    graph = :digraph.new()

    for {index, _height} <- heights do
      :digraph.add_vertex(graph, index)
    end

    for {{row_index, column_index} = start_index, start_height} <- heights,
        search_index <- [
          {row_index, column_index - 1},
          {row_index, column_index + 1},
          {row_index - 1, column_index},
          {row_index + 1, column_index}
        ],
        Map.has_key?(heights, search_index),
        search_height = Map.fetch!(heights, search_index),
        search_height <= start_height + 1 do
      :digraph.add_edge(graph, start_index, search_index)
    end

    path = :digraph.get_short_path(graph, start_position, end_position)

    IO.puts(length(path) - 1)
  end
end
