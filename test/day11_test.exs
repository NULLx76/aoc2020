defmodule Day11Test do
  use ExUnit.Case, async: true
  import Day11

  test "part1" do
    assert part1("./inputs/day11_ex1.txt") == 37
    assert part1() == 2113
  end

  test "part2" do
    assert part2("./inputs/day11_ex1.txt") == 26
    assert part2() == 1865
  end
end
