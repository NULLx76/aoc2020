defmodule DayTwoTest do
  use ExUnit.Case, async: true

  import DayTwo

  test "is_valid" do
    assert is_valid?("1-3 a: abcde")
    assert !is_valid?("1-3 b: cdefg")
    assert is_valid?("2-9 c: ccccccccc")
  end

  test "is_valid2" do
    assert is_valid2?("1-3 a: abcde")
    assert !is_valid2?("1-3 b: cdefg")
    assert !is_valid2?("2-9 c: ccccccccc")
  end

  test "part1" do
    assert part1() == 424
  end

  test "part2" do
    assert part2() == 747
  end
end
