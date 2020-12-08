defmodule Day08Test do
  use ExUnit.Case, async: true
  import Day08

  test "part1" do
    assert part1("./inputs/day8_ex.txt") == 5
    assert part1() == 1563
  end

  test "part2" do
    assert part2("./inputs/day8_ex.txt") == 8
    assert part2() == 767
  end
end
