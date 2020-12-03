defmodule Day03Test do
  use ExUnit.Case, async: true

  import Day03

  test "part1" do
    assert part1() == 242
  end

  test "part2" do
    assert part2() == 2_265_549_792
  end
end
