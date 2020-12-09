defmodule Day09Test do
  use ExUnit.Case
  import Day09

  test "part1" do
    assert part1() == 466_456_641
  end

  test "part2" do
    assert part2(true) == 55_732_936
    assert part2(false) == 55_732_936
  end
end
