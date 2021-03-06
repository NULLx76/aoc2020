defmodule Day15Test do
  use ExUnit.Case, async: true

  import Day15

  test "part1" do
    assert part1() == 614
  end

  @tag timeout: 120_000
  test "part2" do
    assert part2() == 1065
  end
end
