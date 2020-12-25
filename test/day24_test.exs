defmodule Day24Test do
  use ExUnit.Case, async: true

  import Day24

  test "part1" do
    assert part1() == 332
  end

  test "part2" do
    assert part2() == 3900
  end
end
