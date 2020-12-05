defmodule Day05Test do
  use ExUnit.Case, async: true
  import Day05

  @rowrange 0..127
  @colrange 0..7

  test "decode" do
    assert decode("BFFFBBFRRR", @rowrange, @colrange) == {70, 7}
    assert decode("FFFBBBFRRR", @rowrange, @colrange) == {14, 7}
    assert decode("BBFFBBFRLL", @rowrange, @colrange) == {102, 4}
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
