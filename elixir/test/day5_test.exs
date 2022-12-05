defmodule AOC.Day5Test do
  use ExUnit.Case
  import Assertions, only: [assert_lists_equal: 2]
  alias AOC.Day5
  doctest Day5

  @simple "day5/simple_input.txt"
  @complex "day5/complex_input.txt"

  test "Splits up input to two parts" do
    parts =
      @simple
      |> Day5.get_input_parts()

    assert length(parts) == 2
  end

  test "parses crane section correctly" do
    [crane, _] =
      @simple
      |> Day5.get_input_parts()

    crane =
      crane
      |> Day5.parse_crane()

    assert 3 == length(crane)
    [one, two, three] = crane
    assert 2 == length(one)
    assert 3 == length(two)
    assert 1 == length(three)
  end

  test "parses movement section correctly" do
    [_, moves] =
      @simple
      |> Day5.get_input_parts()

    moves
    |> Day5.parse_movements()
    |> assert_lists_equal([[1, 2, 1], [3, 1, 3], [2, 2, 1], [1, 1, 2]])
  end

  test "parses everything correctly" do
    [crane, moves] =
      @simple
      |> Day5.get_input_parts()

    crane = Day5.parse_crane(crane)
    moves = Day5.parse_movements(moves)
    assert length(crane) == 3
    assert length(moves) == 4
  end

  test "performs movements correctly" do
    {crane, moves} =
      @simple
      |> Day5.get_input_parts()
      |> Day5.parse_input_parts()

    [move1, move2, move3, move4] = moves

    v = :v9000

    crane_1 = {crane, move1} |> Day5.perform_move(v)

    [crane_1_1, crane_1_2, crane_1_3] = crane_1
    # , "1"])
    assert_lists_equal(crane_1_1, ["D", "N", "Z"])
    # , "2"])
    assert_lists_equal(crane_1_2, ["C", "M"])
    # , "3"])
    assert_lists_equal(crane_1_3, ["P"])

    crane_2 = {crane_1, move2} |> Day5.perform_move(v)
    [crane_2_1, crane_2_2, crane_2_3] = crane_2
    # "1"])
    assert_lists_equal(crane_2_1, [])
    # , "2"])
    assert_lists_equal(crane_2_2, ["C", "M"])
    # , "3"])
    assert_lists_equal(crane_2_3, ["Z", "N", "D", "P"])

    crane_3 = {crane_2, move3} |> Day5.perform_move(v)
    [crane_3_1, crane_3_2, crane_3_3] = crane_3
    # , "1"])
    assert_lists_equal(crane_3_1, ["M", "C"])
    # "2"])
    assert_lists_equal(crane_3_2, [])
    # , "3"])
    assert_lists_equal(crane_3_3, ["Z", "N", "D", "P"])

    crane_4 = {crane_3, move4} |> Day5.perform_move(v)
    [crane_4_1, crane_4_2, crane_4_3] = crane_4
    # , "1"])
    assert_lists_equal(crane_4_1, ["C"])
    # , "2"])
    assert_lists_equal(crane_4_2, ["M"])
    # , "3"])
    assert_lists_equal(crane_4_3, ["Z", "N", "D", "P"])

    [one | _] = crane_4_1
    [two | _] = crane_4_2
    [three | _] = crane_4_3

    assert one <> two <> three == "CMZ"
  end

  test "finds complex value" do
    assert "BSDMQFLSP" ==
             @complex
             |> Day5.get_input_parts()
             |> Day5.parse_input_parts()
             |> Day5.perform_moves(:v9000)
             |> Enum.map(&Enum.at(&1, 0))
             |> Enum.join()
  end

  test "performs movements correctly, even with 9001" do
    {crane, moves} =
      @simple
      |> Day5.get_input_parts()
      |> Day5.parse_input_parts()

    v = :v9001
    [move1, move2, move3, move4] = moves

    crane_1 = {crane, move1} |> Day5.perform_move(v)

    [crane_1_1, crane_1_2, crane_1_3] = crane_1
    # , "1"])
    assert_lists_equal(crane_1_1, ["D", "N", "Z"])
    # , "2"])
    assert_lists_equal(crane_1_2, ["C", "M"])
    # , "3"])
    assert_lists_equal(crane_1_3, ["P"])

    crane_2 = {crane_1, move2} |> Day5.perform_move(v)
    [crane_2_1, crane_2_2, crane_2_3] = crane_2
    # "1"])
    assert_lists_equal(crane_2_1, [])
    # , "2"])
    assert_lists_equal(crane_2_2, ["C", "M"])
    # , "3"])
    assert_lists_equal(crane_2_3, ["D", "N", "Z", "P"])

    crane_3 = {crane_2, move3} |> Day5.perform_move(v)
    [crane_3_1, crane_3_2, crane_3_3] = crane_3
    # , "1"])
    assert_lists_equal(crane_3_1, ["M", "C"])
    # "2"])
    assert_lists_equal(crane_3_2, [])
    # , "3"])
    assert_lists_equal(crane_3_3, ["Z", "N", "D", "P"])

    crane_4 = {crane_3, move4} |> Day5.perform_move(v)
    [crane_4_1, crane_4_2, crane_4_3] = crane_4
    # , "1"])
    assert_lists_equal(crane_4_1, ["M"])
    # , "2"])
    assert_lists_equal(crane_4_2, ["C"])
    # , "3"])
    assert_lists_equal(crane_4_3, ["Z", "N", "D", "P"])

    [one | _] = crane_4_1
    [two | _] = crane_4_2
    [three | _] = crane_4_3

    assert one <> two <> three == "MCD"
  end

  test "finds complex value with 9001" do
    assert "PGSQBFLDP" ==
             @complex
             |> Day5.get_input_parts()
             |> Day5.parse_input_parts()
             |> Day5.perform_moves(:v9001)
             |> Enum.map(&Enum.at(&1, 0))
             |> Enum.join()
  end
end
