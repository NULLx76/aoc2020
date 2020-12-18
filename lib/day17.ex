defmodule Day17 do
  @moduledoc "Day Seventeen of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index()
    |> Enum.map(fn {v, y} ->
      Enum.into(v, %{}, fn {el, x} -> {{x, y, 0, 0}, el} end)
    end)
    |> Enum.reduce(&Map.merge/2)
  end

  def part1(file \\ "./inputs/day17.txt") do
    parse(file)
    :noop
  end

  def part2(file \\ "./inputs/day17.txt") do
    parse(file)
    :noop
  end
end
