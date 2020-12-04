defmodule Day03 do
  @moduledoc "Day Three of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
  end

  defp slope(input, {dx, dy}) do
    slope(input, {dx, dy, 0, 0}, 0)
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

  def part1(file \\ "./inputs/day3.txt") do
    parse(file)
    |> slope({3, 1})
  end

  def part2(file \\ "./inputs/day3.txt") do
    input = parse(file)

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(&slope(input, &1))
    |> Enum.reduce(&(&1 * &2))
  end
end
