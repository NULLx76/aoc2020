
defmodule DayOneTest do
  use ExUnit.Case

  import DayOne

  test "part1" do
    assert part1() == 1009899
  end

  test "part2" do 
    assert part2() == 44211152
  end
end