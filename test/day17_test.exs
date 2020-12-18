defmodule Day17Test do
  use ExUnit.Case, async: true

  import Day17

  test "part1" do
    assert part1() == 289
  end

  test "part2" do
    assert part2() == 2084
  end
end
