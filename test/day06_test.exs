defmodule Day06Test do
  use ExUnit.Case, async: true
  import Day06

  test "part1" do
    assert part1() == 6930
  end

  test "part2" do
    assert part2() == 3585
  end
end
