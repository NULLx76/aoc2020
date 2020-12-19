defmodule Day19 do
  def part1 do
    Rust.day19_part1()
  end

  def part2 do
    File.read!("./inputs/day19.txt")
    |> Python.day19_part2()
  end
end
