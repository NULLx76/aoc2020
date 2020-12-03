defmodule DayOneTest do
  use ExUnit.Case, async: true

  import DayOne

  test "part1" do
    assert part1() == 1_009_899
  end

  test "part2" do
    assert part2() == 44_211_152
  end
end
