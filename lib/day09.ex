defmodule Day09 do
  @moduledoc "Day Nine of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
  end

  def part1(file \\ "./inputs/day9.txt") do
    parse(file)
  end

  def part2(file \\ "./inputs/day9.txt") do
    parse(file)
  end
end
