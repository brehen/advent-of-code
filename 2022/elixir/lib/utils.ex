defmodule AOC.Utils do
  def read_input(file_path) do
    "../assets/#{file_path}"
    |> Path.expand(__DIR__)
    |> File.read!()
  end
end
