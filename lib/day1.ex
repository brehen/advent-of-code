defmodule Day1 do
  def read_input(file_path) do
    "../assets/#{file_path}"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n\n/, trim: true)
  end

  def get_result(file_path) do
      read_input(file_path)
      |> Enum.map(fn gnome -> String.split(gnome, ~r/\n/, trim: true) end)
      |> Enum.map(fn gnome -> Enum.map(gnome, &String.to_integer/1) end)
      |> Enum.map(fn gnome -> Enum.sum(gnome) end)
  end

  def get_highest(result) do
    result |> Enum.max()
  end
end
