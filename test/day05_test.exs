defmodule Day05Test do
  use ExUnit.Case, async: true

  import Day05

  test "decode" do
    assert decode("BFFFBBFRRR", 0..127, 0..7) == {70, 7}
    assert decode("FFFBBBFRRR", 0..127, 0..7) == {14, 7}
    assert decode("BBFFBBFRLL", 0..127, 0..7) == {102, 4}
  end

  test "seat id" do
    assert seat_id({70, 7}) == 567
    assert seat_id({14, 7}) == 119
    assert seat_id({102, 4}) == 820
  end

  test "part1" do
    assert part1() == 930
  end

  test "part2" do
    assert part2() == 515
  end
end
