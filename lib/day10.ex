defmodule Day10 do
  @moduledoc "Day Ten of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
  end

  def part1(file \\ "./inputs/day10.txt") do
    parse(file)
  end

  def part2(file \\ "./inputs/day10.txt") do
    parse(file)
  end
end
