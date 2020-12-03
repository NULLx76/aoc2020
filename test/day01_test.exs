defmodule Day01Test do
  use ExUnit.Case, async: true

  import Day01

  test "part1" do
    assert part1() == 1_009_899
  end

  test "part2" do
    assert part2() == 44_211_152
  end
end
