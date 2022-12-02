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

  # Inverse the win-map to determine how to lose
  @loses Map.new(@beats, fn { key, val } -> { val, key } end)


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

  defp get_move(key), do: Map.get(@moves, key)

  def get_mapped_moves([elf, me]), do: [get_move(elf), get_move(me)]

  def get_moves(rounds) do
    rounds
    |> Enum.map(&get_mapped_moves(&1))
  end

  def get_rounds(file_path) do
      read_input(file_path)
      |> String.split(~r/\n/, trim: true)
      |> Enum.map(fn line -> 
        line
        |> String.split(~r/\n/, trim: true)
        |> Enum.flat_map(&String.split(&1, " ", trim: true))
      end)
  end

  def get_mapped_rounds_1(rounds) do
    rounds
    |> Enum.map(&get_mapped_moves/1)
  end

  def get_mapped_rounds_2(rounds) do
    rounds
    |> Enum.map(&get_move_from_strat/1)
  end


  # Lose
  defp get_move_from_strat([elf, "X"]) do
    elf_move = get_move(elf)
    losing_move = Map.get(@beats, elf_move)
    [elf_move, losing_move]
  end

  # Draw
  defp get_move_from_strat([elf, "Y"]), do: [get_move(elf), get_move(elf)]

  # Win
  defp get_move_from_strat([elf, "Z"]) do
    elf_move = get_move(elf)
    winning_move = Map.get(@loses, elf_move)
    [elf_move, winning_move]
  end

  def get_score_from_round([elf, me]) do
    result = determine_outcome([elf, me])
    score = case result do
      :win -> 6
      :draw -> 3
      :lose -> 0
    end

    score + Map.get(@values, me)
  end

  defp determine_outcome([elf_move, my_move]) when elf_move == my_move, do: :draw
  defp determine_outcome([elf_move, my_move]) do
    elf_wins = Map.get(@beats, elf_move) == my_move
    case elf_wins do
      true -> :lose
      false -> :win
    end
  end
end
