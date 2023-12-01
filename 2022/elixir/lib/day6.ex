defmodule AOC.Day6 do
  import AOC.Utils, only: [read_input: 1]

  def read_marker(file_path) do
    read_input(file_path)
    |> String.replace(~r/\n/, "")
  end

  def get_marker(packet, target_size) do
    split_packet = String.split(packet, "", trim: true)

    split_packet
    |> Enum.slice(Range.new(0, target_size - 1))
    |> get_marker(split_packet, target_size, target_size)
  end

  def get_marker(slice, packet, value, target_size) do
    packet_size =
      slice
      |> Enum.uniq()
      |> length

    # If packet doesn't contain 4 unique characters
    if packet_size < target_size do
      packet
      |> Enum.slice(Range.new(value - target_size + 1, value))
      |> get_marker(packet, value + 1, target_size)
    else
      value
    end
  end
end
