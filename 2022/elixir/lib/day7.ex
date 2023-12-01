defmodule AOC.Day7 do
  import AOC.Utils, only: [read_input: 1]

  @typedoc """
  A map of the filetree from the root folder 
  """
  @type filetree :: %{String.t() => filetree | integer}

  @spec read_command_list(String.t()) :: [String.t()]
  def read_command_list(file_path), do: read_input(file_path) |> String.split(~r/\n/, trim: true)

  @spec parse_commands([String.t()]) :: [[String.t()]]
  def parse_commands(commands) do
    parse_commands(commands, [])
  end

  def parse_commands([], parsed), do: Enum.reverse(parsed)

  def parse_commands([command | commands], parsed) do
    parse_commands(commands, [parse_command(command) | parsed])
  end

  defp parse_command(command) do
    String.split(command, " ", trim: true)
  end

  @spec parse_filetree([String.t()]) :: filetree
  def parse_filetree(commands) do
    {_, tree} =
      commands
      |> IO.inspect()
      |> Enum.reduce({[], %{}}, fn
        # Move to root
        ["$", "cd", "/"], {_, tree} ->
          {["/"], tree}

        # Move up
        ["$", "cd", ".."], {[_pop_out | new_location], tree} ->
          {new_location, tree}

        # Move into folder
        ["$", "cd", dir], {location, tree} ->
          {[dir | location], tree}

        ["$", "ls"], acc ->
          acc

        ["dir", _], acc ->
          acc

        [file_size, file_name], {location, tree} ->
          IO.inspect({Enum.reverse(location), file_size, file_name})

          updated_tree =
            tree
            |> put_in(
              Enum.map(
                Enum.reverse([file_name | location]),
                &Access.key(&1, %{})
              ),
              String.to_integer(file_size)
            )

          curr_dir_size =
            get_in(updated_tree, Enum.reverse(["size" | location]))
            |> Kernel.||(0)

          tree_with_dir_size =
            updated_tree
            |> put_in(
              Enum.reverse(["size" | location]),
              Enum.sum([String.to_integer(file_size), curr_dir_size])
            )

          {location, tree_with_dir_size}

        _, acc ->
          acc
      end)

    tree
  end

  def gave_up_and_googled(help) do
    help
    |> read_command_list()
    |> Stream.reject(&(&1 == "$ ls" || match?("dir " <> _, &1)))
    |> Stream.transform(
      # start_fun
      fn -> [0] end,

      # reducer
      fn
        "$ cd ..", [leaving_size, parent_size | stack] ->
          {[leaving_size], [parent_size + leaving_size | stack]}

        "$ cd " <> _, stack ->
          {[], [0 | stack]}

        file, [size | stack] ->
          [filesize, _] = String.split(file, " ")
          {[], [size + String.to_integer(filesize) | stack]}
      end,

      # last_fun
      &Enum.flat_map_reduce(&1, &1, fn
        _, [size, dirsize | remainder] -> {[size], [dirsize + size | remainder]}
        _, [_remainder] -> {[], nil}
      end),

      # after_fun
      &Function.identity/1
    )
    |> Enum.to_list()
    |> Enum.reverse()
  end
end
