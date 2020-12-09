defmodule Day04Test do
  use ExUnit.Case, async: true

  import Day04

  test "part1" do
    assert part1() == 239
    assert part1("./inputs/day04_ex1.txt") == 2
  end

  test "part2" do
    assert part2() == 188
    assert part2("./inputs/day04_ex2.txt") == 4
  end
end
