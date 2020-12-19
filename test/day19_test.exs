defmodule Day19Test do
  use ExUnit.Case, async: true

  import Day19

  test "part1" do
    assert part1() == 156
  end

  test "part2" do
    assert part2() == 363
  end
end
