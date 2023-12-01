defmodule AOC.Day9 do
  import AOC.Utils, only: [read_input: 1]

  @type head :: [{Integer.t(), Integer.t()}]
  @type move :: {String.t(), Integer.t()}

  def get_moves(file_path) do
    read_input(file_path)
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(&String.split(&1, ~r/\s/, trim: true))
    |> Enum.map(fn [dir, dist] -> {dir, String.to_integer(dist)} end)
  end

  @spec do_all_moves([move]) :: head
  def do_all_moves(moves) do
    moves
    |> Enum.reduce([{0, 0}], fn move, acc ->
      move_head(acc, move)
    end)
    |> Enum.reverse()
  end

  @spec determine_tail_path(head) :: head
  def determine_tail_path(head) do
    head
    |> Enum.reduce([], fn
      head, [] ->
        [head]

      {new_head_x, new_head_y}, acc ->
        [tail_pos | _] = acc

        is_in_bound = is_within_bounds({new_head_x, new_head_y}, tail_pos)

        new_tail_pos =
          case is_in_bound do
            true -> tail_pos
            false -> catch_up_to_head({new_head_x, new_head_y}, tail_pos)
          end

        [new_tail_pos | acc]
    end)
    |> Enum.reverse()
  end

  # If head has gone ahead
  @spec catch_up_to_head(move, move) :: move
  def catch_up_to_head({h_x, h_y}, {t_x, t_y}) do
    direction = get_dir({h_x, h_y}, {t_x, t_y})

    {t_x, t_y} =
      case direction do
        "R" -> {t_x + 1, t_y}
        "L" -> {t_x - 1, t_y}
        "U" -> {t_x, t_y + 1}
        "D" -> {t_x, t_y - 1}
        "NW" -> {t_x - 1, t_y + 1}
        "NE" -> {t_x + 1, t_y + 1}
        "SW" -> {t_x - 1, t_y - 1}
        "SE" -> {t_x + 1, t_y - 1}
      end

    {t_x, t_y}
  end

  # Going horizontally while both on same horizontal plane
  @spec get_dir(move, move) :: String.t()
  defp get_dir({h_x, h_y}, {t_x, t_y}) when h_y == t_y do
    if h_x > t_x do
      "R"
    else
      "L"
    end
  end

  # Going vertically while both on same horizontal plane
  defp get_dir({h_x, h_y}, {t_x, t_y}) when h_x == t_x do
    if h_y > t_y do
      "U"
    else
      "D"
    end
  end

  # Catch up diagnocally
  defp get_dir({h_x, h_y}, {t_x, t_y}) do
    if h_y > t_y do
      if h_x > t_x do
        "NE"
      else
        "NW"
      end
    else
      if h_x < t_x do
        "SW"
      else
        "SE"
      end
    end
  end

  def is_within_bounds({h_x, h_y}, {t_x, t_y}),
    do: is_in_x_range({h_x, t_x}) and is_in_y_range({h_y, t_y})

  def is_in_x_range({h_x, t_x}), do: t_x in Range.new(h_x - 1, h_x + 1)

  def is_in_y_range({h_y, t_y}), do: t_y in Range.new(h_y - 1, h_y + 1)

  @spec move_head(head, move) :: head
  def move_head(head, {dir, dist}) do
    [curr_loc | _] = head

    new_moves =
      Enum.to_list(Range.new(0, dist - 1))
      |> Enum.reduce([], fn
        _, [] -> [move(dir, curr_loc)]
        _, [curr | acc] -> [move(dir, curr), curr | acc]
      end)

    Enum.concat(new_moves, head)
  end

  def move("R", {x, y}), do: {x + 1, y}
  def move("L", {x, y}), do: {x - 1, y}
  def move("U", {x, y}), do: {x, y + 1}
  def move("D", {x, y}), do: {x, y - 1}

  def get_touched_points(tail) do
    tail
    |> Enum.uniq()
    |> length
  end
end
