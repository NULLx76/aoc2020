defmodule Day10 do
  @moduledoc "Day Ten of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1(file \\ "./inputs/day10.txt") do
    {ones, threes} =
      [0 | parse(file)]
      |> Enum.sort()
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce({0, 0}, fn [l, r], {ones, threes} ->
        case r - l do
          3 -> {ones, threes + 1}
          1 -> {ones + 1, threes}
          _ -> {ones, threes}
        end
      end)

    ones * (threes + 1)
  end

  defp count(list, map \\ %{0 => 1})
  defp count([n], map), do: sum_prev(n, map)

  defp count([h | t], map) do
    count(t, Map.put(map, h, sum_prev(h, map)))
  end

  defp sum_prev(n, map) do
    Map.get(map, n - 1, 0) + Map.get(map, n - 2, 0) + Map.get(map, n - 3, 0)
  end

  def part2(file \\ "./inputs/day10.txt") do
    parse(file)
    |> Enum.sort()
    |> count()
  end
end
