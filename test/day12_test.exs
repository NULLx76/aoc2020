defmodule Day12Test do
  use ExUnit.Case, async: true
  import Day12

  test "part1" do
    assert part1() == 1496
  end

  test "part2" do
    assert part2() == 63_843
  end
end
