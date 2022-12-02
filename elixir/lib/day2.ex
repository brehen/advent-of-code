defmodule AOC.Day2 do
  @moves %{
    "A" => "rock",
    "B" => "paper",
    "C" => "scissors",
    "X" => "rock",
    "Y" => "paper",
    "Z" => "scissors"
  }

  @beats %{
    "paper" => "rock",
    "rock" => "scissors",
    "scissors" => "paper"
  }

  @values %{
    "rock" => 1,
    "paper" => 2,
    "scissors" => 3,
  }

  def read_input(file_path) do
    "../assets/#{file_path}"
    |> Path.expand(__DIR__)
    |> File.read!()
  end

  def get_rounds(file_path) do
      read_input(file_path)
      |> String.split(~r/\n/, trim: true)
      |> Enum.map(fn line -> 
        line
        |> String.split(~r/\n/, trim: true)
        |> Enum.flat_map(&String.split(&1, " ", trim: true))
      end)
      |> Enum.map(&get_mapped_moves(&1))
  end

  def get_mapped_moves([elf, me]), do: [Map.get(@moves, elf), Map.get(@moves, me)]

  def get_moves(rounds) do
    rounds
    |> Enum.map(&get_mapped_moves(&1))
  end

  def get_score_from_round([elf, me]) do
    result = determine_outcome([elf, me])
    score = case result do
      :win -> 6
      :lose -> 0
      :draw -> 3
      _ -> 0
    end

    score + Map.get(@values, me)
  end

  defp determine_outcome([elf_move, my_move]) when elf_move == my_move, do: :draw
  defp determine_outcome([elf_move, my_move]) do
    elf_wins = Map.get(@beats, elf_move) == my_move
    if elf_wins do
      :lose
    else
      :win
    end
  end
end
