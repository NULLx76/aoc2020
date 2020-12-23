defmodule Day23Test do
  use ExUnit.Case, async: true

  import Day23

  test "part1" do
    assert part1() == 94_238_657
  end

  # @tag :skip
  test "part2" do
    assert part2() == 3_072_905_352
  end
end
