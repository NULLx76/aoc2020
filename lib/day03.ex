defmodule Day03 do
  @moduledoc "Day Three of the AoC"

  def parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
  end

  defp slope(input, {dx, dy, x, y}, count) do
    line = Enum.at(input, y)

    if line == nil do
      count
    else
      if String.at(line, rem(x, String.length(line))) == "#" do
        slope(input, {dx, dy, x + dx, y + dy}, count + 1)
      else
        slope(input, {dx, dy, x + dx, y + dy}, count)
      end
    end
  end

  def part1 do
    parse("./inputs/day3.txt")
    |> slope({3, 1, 0, 0}, 0)
  end

  def part2 do
    input = parse("./inputs/day3.txt")

    [{1, 1, 0, 0}, {3, 1, 0, 0}, {5, 1, 0, 0}, {7, 1, 0, 0}, {1, 2, 0, 0}]
    |> Enum.map(&slope(input, &1, 0))
    |> Enum.reduce(&(&1 * &2))
  end
end
