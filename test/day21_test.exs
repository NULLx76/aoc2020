defmodule Day21Test do
  use ExUnit.Case, async: true

  import Day21

  test "part1" do
    assert part1() == 2786
  end

  test "part2" do
    assert part2() == "prxmdlz,ncjv,knprxg,lxjtns,vzzz,clg,cxfz,qdfpq"
  end
end
