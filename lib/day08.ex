defmodule Day08 do
  @moduledoc "Day Eight of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
  end

  def part1(file \\ "./inputs/day8.txt") do
    parse(file)
  end

  def part2(file \\ "./inputs/day8.txt") do
    parse(file)
  end
end
