defmodule Day15 do
  @moduledoc "Day Fifteen of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def init(nums) do
    nums
    |> Enum.with_index()
    |> Enum.map(fn {v, i} -> {v, [i + 1]} end)
    |> Map.new()
  end

  def turn(turn, last, _, _, limit) when turn == limit + 1, do: last

  def turn(turn, last, is_first, seen, limit) do
    n =
      if is_first do
        0
      else
        [a, b | _] = Map.get(seen, last)
        a - b
      end

    if Map.get(seen, n) == nil do
      turn(turn + 1, n, true, Map.put(seen, n, [turn]), limit)
    else
      turn(turn + 1, n, false, Map.update!(seen, n, fn [h | _] -> [turn, h] end), limit)
    end
  end

  def part1(file \\ "./inputs/day15.txt") do
    list = file |> parse()
    seen = list |> init()

    turn(length(list) + 1, List.last(list), true, seen, 2020)
  end

  def part2(file \\ "./inputs/day15.txt") do
    list = file |> parse()
    seen = list |> init()

    turn(length(list) + 1, List.last(list), true, seen, 30_000_000)
  end
end
