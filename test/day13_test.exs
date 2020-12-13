defmodule Day13Test do
  use ExUnit.Case, async: true
  import Day13

  test "part1" do
    assert part1() == 3882
  end

  test "part2" do
    assert part2() == 867_295_486_378_319
  end
end
