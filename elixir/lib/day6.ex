defmodule AOC.Day6 do
  import AOC.Utils, only: [read_input: 1]

  def read_marker(file_path) do
    read_input(file_path)
    |> String.replace(~r/\n/, "")
  end

  def get_marker(packet) do
    packet =
      packet
      |> String.split("", trim: true)

    packet
    |> Enum.slice(0..3)
    |> get_marker(packet, 4)
  end

  def get_marker(slice, packet, value) do
    IO.inspect({slice, packet})

    packet_size =
      slice
      |> Enum.uniq()
      |> length

    # If packet doesn't contain 4 unique characters
    if packet_size < 4 do
      packet
      |> Enum.slice(Range.new(value - 3, value))
      |> get_marker(packet, value + 1)
    else
      value
    end
  end
end
