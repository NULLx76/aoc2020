defmodule Day25Test do
  use ExUnit.Case, async: true

  import Day25

  test "part1" do
    assert part1() == 16_311_885
  end

  test "part2" do
    assert part2() == "Free star!"
  end
end
