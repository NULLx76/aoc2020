defmodule Day16Test do
  use ExUnit.Case, async: true

  import Day16

  test "part1" do
    assert part1() == 21_980
    assert part1("./inputs/day16_ex1.txt") == 71
  end

  test "part2" do
    assert part2() == 1_439_429_522_627
  end
end
