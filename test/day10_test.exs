defmodule Day10Test do
  use ExUnit.Case
  import Day10

  test "part1" do
    assert part1() == 2482
  end

  test "part2" do
    assert part2() == 96_717_311_574_016
  end
end
