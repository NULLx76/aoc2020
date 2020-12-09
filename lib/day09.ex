defmodule Day09 do
  @moduledoc "Day Nine of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1(file \\ "./inputs/day09.txt", preamble \\ 25) do
    parse(file)
    |> Enum.chunk_every(preamble + 1, 1, :discard)
    |> Enum.reduce_while(0, fn el, acc ->
      target = Enum.at(el, preamble)

      sums =
        Enum.take(el, preamble)
        |> Combination.combine(2)
        |> Enum.map(&Enum.sum/1)

      if Enum.member?(sums, target) do
        {:cont, acc}
      else
        {:halt, target}
      end
    end)
  end

  def part2(file \\ "./inputs/day09.txt", preamble \\ 25) do
    part1(file, preamble)
    |> find(parse(file))
  end

  defp find(target, data, range \\ 2) do
    pos =
      Enum.chunk_every(data, range, 1, :discard)
      |> Enum.map(fn x -> {x, Enum.sum(x)} end)

    if Enum.member?(Enum.map(pos, &elem(&1, 1)), target) do
      {slice, _} = Enum.find(pos, fn {_, s} -> s == target end)
      Enum.min(slice) + Enum.max(slice)
    else
      find(target, data, range + 1)
    end
  end
end
