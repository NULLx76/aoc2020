defmodule Day06 do
  @moduledoc "Day Six of the AoC"

  defp count_answers(list, :anyone), do: count_answers(list, &MapSet.union/2)
  defp count_answers(list, :everyone), do: count_answers(list, &MapSet.intersection/2)

  defp count_answers(list, f) do
    list
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(f)
    |> Enum.count()
  end

  defp parse(file) do
    File.read!(file)
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split/1)
  end

  def part1(file \\ "./inputs/day6.txt") do
    parse(file)
    |> Enum.map(&count_answers(&1, :anyone))
    |> Enum.sum()
  end

  def part2(file \\ "./inputs/day6.txt") do
    parse(file)
    |> Enum.map(&count_answers(&1, :everyone))
    |> Enum.sum()
  end
end
