defmodule Day07Test do
  use ExUnit.Case, async: true
  import Day07

  test "part1" do
    assert part1("./inputs/day7_ex1.txt") == 4
    assert part1() == 326
  end

  test "part2" do
    assert part2("./inputs/day7_ex2.txt") == 126
    assert part2() == 5635
  end
end
