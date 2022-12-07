defmodule AOC.Day7Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day7
  doctest Day7

  @simple "day7/simple_input.txt"
  @complex "day7/complex_input.txt"

  # Expected formata
  #  @target_simple_total_size(
  #  48_381_165,

  @target_simple_filesystem %{
    "/" => %{
      "a" => %{
        "e" => %{
          "i" => 584,
          "size" => 584
        },
        "f" => 29116,
        "g" => 2557,
        "h.lst" => 62596,
        "size" => 94269
      },
      "b.txt" => 14_848_514,
      "c.dat" => 8_504_156,
      "d" => %{
        "j" => 4_060_174,
        "d.log" => 8_033_020,
        "d.ext" => 5_626_152,
        "k" => 7_214_296,
        "size" => 24_933_642
      },
      "size" => 23_352_670
    }
  }

  @target_simple_folder_sizes %{
    "/" => %{
      "a" => %{
        "size" => 94853,
        "e" => %{
          "size" => 584
        }
      },
      "d" => %{
        "size" => 24_933_642
      },
      "size" => 48_381_165
    }
  }

  @tag :skip
  test "parses command list correctly" do
    commands =
      @simple
      |> Day7.read_command_list()
      |> Day7.parse_commands()

    #      |> IO.inspect()
  end

  @tag :skip
  test "parses filetree correctly" do
    result =
      @simple
      |> Day7.read_command_list()
      |> Day7.parse_commands()
      |> Day7.parse_filetree()
      |> IO.inspect(pretty: true, width: 40)

    assert result == @target_simple_filesystem
  end

  @tag :skip
  test "finds all folder sizes" do
    result =
      @simple
      |> Day7.read_command_list()
      |> Day7.parse_commands()
      |> Day7.parse_filetree()
      |> Day7.filter_files_from_tree()
      |> IO.inspect()
      |> Day7.add_sub_dir_to_size()

    assert @target_simple_folder_sizes == result
  end

  test "Gave it a shot" do
    all_sizes = Day7.gave_up_and_googled(@complex)
    to_free = 30_000_000 + hd(all_sizes) - 70_000_000

    all_sizes |> Enum.filter(&(&1 >= to_free)) |> Enum.min() |> IO.inspect()
  end
end
