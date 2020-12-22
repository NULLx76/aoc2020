defmodule Day22Test do
  use ExUnit.Case, async: true

  import Day22

  test "part1" do
    assert part1() == 32_598
  end

  test "part2" do
    assert part2() == 35_836
  end
end
