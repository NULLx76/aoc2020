defmodule Day18Test do
  use ExUnit.Case, async: true

  import Day18

  test "part1" do
    assert part1() == 18_213_007_238_947
  end

  test "part2" do
    assert part2() == 388_966_573_054_664
  end
end
