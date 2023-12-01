defmodule AOC.Day14 do
  import AOC.Utils, only: [read_input: 1]
  @sand_spawn {500, 1}

  def get_cave(file_path) do
    paths =
      read_input(file_path)
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(" -> ", trim: true)
        |> Enum.map(fn part ->
          part
          |> String.split(",", trim: true)
          |> Enum.map(&String.to_integer/1)
          |> List.to_tuple()
        end)
      end)

    rocks = get_rocks(paths)

    edges =
      paths
      |> get_edges()

    cave = map_cave(edges, rocks)

    {cave, edges}
  end

  def drop_sand(cave, edges), do: drop_sand(cave, 1)
  def drop_sand(cave, 0, _edges), do: cave

  def drop_sand(cave, how_many, edges) do
    {_, _, left, right} = edges
    sand_location = can_sand_move(cave, {500, 1}, {left, right})

    cave =
      cave
      |> Map.put(sand_location, :sand)

    # IO.puts((how_many - 28) * -1)
    #    IO.puts(draw_cave(cave, edges))

    cave
    |> drop_sand(how_many - 1, edges)
  end

  def can_sand_move(cave, {x, y}, {min_x, max_x} = edges) when x not in [min_x, max_x] do
    s = Map.get(cave, {x, y + 1})
    can_go_sw = Map.get(cave, {x - 1, y + 1}) == :air
    can_go_se = Map.get(cave, {x + 1, y + 1}) == :air

    case s do
      :air ->
        can_sand_move(cave, {x, y + 1}, edges)

      :rock when not can_go_sw or not can_go_se ->
        {x, y}

      :rock ->
        can_sand_move(cave, {x - 1, y + 1}, edges)

      :sand ->
        # First check left
        w = Map.get(cave, {x - 1, y})
        sw = Map.get(cave, {x - 1, y + 1})

        case {w, sw} do
          {_, :air} ->
            can_sand_move(cave, {x - 1, y + 1}, edges)

          {:rock, :rock} ->
            {x, y}

          {:sand, :rock} when can_go_se ->
            can_sand_move(cave, {x + 1, y + 1}, edges)

          {:sand, :rock} when can_go_sw ->
            can_sand_move(cave, {x - 1, y + 1}, edges)

          {:sand, :rock} ->
            {x, y}

          {:air, :rock} ->
            {x, y}

          {_, :sand} ->
            e = Map.get(cave, {x + 1, y})
            se = Map.get(cave, {x + 1, y + 1})

            case {e, se} do
              {_, :air} ->
                can_sand_move(cave, {x + 1, y + 1}, edges)

              {_right, _} ->
                {x, y}
            end
        end
    end
  end

  def can_sand_move(cave, _, _), do: cave

  def get_rocks(paths) do
    paths
    |> Enum.map(&range_from_path/1)
    |> List.flatten()
    |> MapSet.new()
  end

  def range_from_path([{x_start, y_start}, {x_end, y_end}]) when x_start == x_end do
    Enum.map(y_start..y_end, &{x_start, &1})
  end

  def range_from_path([{x_start, y_start}, {x_end, y_end}]) when y_start == y_end do
    Enum.map(x_start..x_end, &{&1, y_start})
  end

  def range_from_path([start, finish | rest]) do
    [range_from_path([start, finish]) | range_from_path([finish | rest])]
  end

  def draw_cave(cave, {up, down, left, right}) do
    Enum.map_join(up..down, "\n", fn y ->
      Enum.map_join(left..right, "", fn x ->
        case cave[{x, y}] do
          :rock -> "#"
          :air -> "."
          :sand -> "o"
          :source -> "+"
        end
      end)
    end)
  end

  def map_cave({up, down, left, right}, rocks) do
    x_dir = left..right
    y_dir = up..down

    Enum.map(y_dir, fn y ->
      Enum.map(x_dir, fn
        500 when y == 0 ->
          {500, 0, :source}

        x ->
          if MapSet.member?(rocks, {x, y}) do
            {x, y, :rock}
          else
            {x, y, :air}
          end
      end)
    end)
    |> List.flatten()
    |> Map.new(fn {x, y, val} -> {{x, y}, val} end)
  end

  # edges: {up, down, left, right}
  def get_edges(paths) do
    {left, right} =
      paths
      |> Enum.flat_map(fn paths ->
        paths
        |> Enum.map(fn {x, _y} -> x end)
      end)
      |> Enum.min_max()

    down =
      paths
      |> Enum.flat_map(fn path ->
        path
        |> Enum.map(fn {_x, y} -> y end)
      end)
      |> Enum.max()

    {0, down, left, right}
  end

  def part1(input) do
    bottom = Enum.max_by(input, &elem(&1, 1)) |> elem(1)
    Stream.unfold(input, &fall(&1, bottom, {500, 0})) |> Enum.count()
  end

  def part2(input) do
    bottom = Enum.max_by(input, &elem(&1, 1)) |> elem(1) |> Kernel.+(2)
    state = (-bottom - 1)..(bottom + 1) |> Stream.map(&{500 + &1, bottom}) |> Enum.into(input)

    Stream.unfold(state, &fall(&1, bottom, {500, 0})) |> Enum.count()
  end

  defp fall(state, bottom, {x, y} = sand) do
    if MapSet.member?(state, {500, 0}) do
      nil
    else
      air = Enum.find([{x, y + 1}, {x - 1, y + 1}, {x + 1, y + 1}], &(!MapSet.member?(state, &1)))

      case air do
        nil -> {state, MapSet.put(state, sand)}
        {_, y} when y > bottom -> nil
        _ -> fall(state, bottom, air)
      end
    end
  end

  def parse_input(file_path) do
    "../assets/#{file_path}"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> Stream.flat_map(&parse_line/1)
    |> MapSet.new()
  end

  defp parse_line(line) do
    line
    |> String.split(~r/\D+/, trim: true)
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(2)
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.flat_map(fn [[a, b], [c, d]] ->
      for x <- a..c, y <- b..d, do: {x, y}
    end)
  end
end
