defmodule AOC.Day8 do
  import AOC.Utils, only: [read_input: 1]

  def parse_trees(file_path) do
    file_path
    |> read_input()
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(fn row ->
      row
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp get_columns(tree_lines), do: tree_lines |> List.zip() |> Enum.map(&Tuple.to_list/1)
  defp get_tree_rows(tree_lines), do: tree_lines |> Enum.with_index()

  def get_scenic_scores(tree_lines) do
    columns = get_columns(tree_lines)

    tree_lines
    |> get_tree_rows()
    |> Enum.map(fn
      {row, row_index} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {tree_height, column_index} ->
          column = Enum.at(columns, column_index)
          get_score_of_tree(tree_height, row_index, column_index, row, column)
        end)
    end)
  end

  defp get_direction(list, range) do
    list
    |> Enum.slice(range)
  end

  def get_direction_score(sliced, height) do
    {_, score} =
      sliced
      |> Enum.find(fn {tree_height, indx} ->
        tree_height >= height or indx == length(sliced)
      end)

    score
  end

  def get_score_of_tree(_height, 0, _column_index, _row_, _column), do: 0
  def get_score_of_tree(_height, _row_index, 0, _row, _column), do: 0

  def get_score_of_tree(_height, row_index, column_index, row, column)
      when row_index == length(row) - 1 or column_index == length(column) - 1,
      do: 0

  def get_score_of_tree(tree_height, row_index, column_index, row, column) do
    up_score =
      column
      |> get_direction(Range.new(0, row_index - 1))
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> get_direction_score(tree_height)

    left_score =
      row
      |> get_direction(Range.new(0, column_index - 1))
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> get_direction_score(tree_height)

    right_score =
      row
      |> get_direction(Range.new(column_index + 1, -1))
      |> Enum.with_index(1)
      |> get_direction_score(tree_height)

    down_score =
      column
      |> get_direction(Range.new(row_index + 1, -1))
      |> Enum.with_index(1)
      |> get_direction_score(tree_height)

    left_score * right_score * up_score * down_score
  end

  def get_visible(tree_lines) do
    # loop over each row
    # for each column in row:
    #   check if tree is visible in any direction
    #      If index === 0 || length(row): yes
    #      If row_index === 0 || length(tree_lines): yes
    #      If item[index] is higher than all in row: yes
    #      If item[index] is higher than all in column: yes
    columns = get_columns(tree_lines)

    tree_line_length = length(tree_lines) - 1

    tree_lines
    |> get_tree_rows()
    |> Enum.reduce([], fn
      {row, 0}, _acc ->
        row
        |> Enum.with_index()

      {row, ^tree_line_length}, acc ->
        row
        |> Enum.with_index()
        |> Enum.concat(acc)

      {row, row_index}, acc ->
        visible_in_row =
          row
          |> get_visible_trees(columns, row_index)

        Enum.concat(visible_in_row, acc)
    end)
  end

  def get_visible_in_any_direction({_tree_height, 0}, _row, _columns), do: true

  def get_visible_in_any_direction({_tree_height, column_index}, {row, _}, _columns)
      when column_index == length(row) - 1,
      do: true

  def get_visible_in_any_direction(
        {tree_height, column_index},
        {tree_row, row_index},
        columns
      ) do
    left =
      tree_row
      |> Enum.slice(Range.new(0, column_index - 1))

    right =
      tree_row
      |> Enum.slice(Range.new(column_index + 1, -1))

    column = Enum.at(columns, column_index)

    up =
      column
      |> Enum.slice(Range.new(0, row_index - 1))

    down =
      column
      |> Enum.slice(Range.new(row_index + 1, -1))

    visible_right = Enum.max(right) < tree_height
    visible_left = Enum.max(left) < tree_height
    visible_up = Enum.max(up) < tree_height
    visible_down = Enum.max(down) < tree_height

    visible_down or visible_left or visible_right or visible_up
  end

  def get_visible_trees(row, columns, row_index) do
    row
    |> Enum.with_index()
    |> Enum.filter(&get_visible_in_any_direction(&1, {row, row_index}, columns))
  end
end
