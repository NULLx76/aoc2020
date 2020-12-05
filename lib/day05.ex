defmodule Day05 do
  @moduledoc "Day Five of the AoC"
  @rowrange 0..127
  @colrange 0..7

  defp slice_range(range, bound) do
    half = div(Enum.count(range), 2)

    case bound do
      :lower -> Enum.slice(range, 0, half)
      :upper -> Enum.slice(range, half, half)
    end
  end

  def decode(seat, row, column) do
    {c, rest} = String.split_at(seat, 1)

    case c do
      "F" -> decode(rest, slice_range(row, :lower), column)
      "B" -> decode(rest, slice_range(row, :upper), column)
      "L" -> decode(rest, row, slice_range(column, :lower))
      "R" -> decode(rest, row, slice_range(column, :upper))
      _ -> {hd(row), hd(column)}
    end
  end

  def seat_id({row, col}), do: row * 8 + col

  def part1(file \\ "./inputs/day5.txt") do
    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&decode(&1, @rowrange, @colrange))
    |> Stream.map(&seat_id/1)
    |> Enum.max()
  end

  def part2(file \\ "./inputs/day5.txt") do
    [a | _] =
      File.read!(file)
      |> String.split("\n", trim: true)
      |> Enum.map(&decode(&1, @rowrange, @colrange))
      |> Enum.map(&seat_id/1)
      |> Enum.sort()
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.find(fn [a, b] -> a - b != -1 end)

    a + 1
  end
end
