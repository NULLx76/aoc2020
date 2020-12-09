defmodule Day09 do
  @moduledoc "Day Nine of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1(file \\ "./inputs/day09.txt", preamble \\ 25) do
    parse(file)
    |> Stream.chunk_every(preamble + 1, 1, :discard)
    |> Enum.reduce_while(0, fn el, acc ->
      target = Enum.at(el, preamble)

      sums =
        Stream.take(el, preamble)
        |> Combination.combine(2)
        |> Stream.map(&Enum.sum/1)

      if Enum.member?(sums, target) do
        {:cont, acc}
      else
        {:halt, target}
      end
    end)
  end

  def part2(bruteforce \\ false, file \\ "./inputs/day09.txt", preamble \\ 25) do
    target = part1(file, preamble)
    data = parse(file)

    if bruteforce do
      find(target, data)
    else
      find2(target, data)
    end
  end

  # Bruteforce implementation
  defp find(target, data, range \\ 2) do
    pos =
      Stream.chunk_every(data, range, 1, :discard)
      |> Stream.map(fn x -> {x, Enum.sum(x)} end)

    if Enum.member?(Stream.map(pos, &elem(&1, 1)), target) do
      {slice, _} = Enum.find(pos, fn {_, s} -> s == target end)
      Enum.min(slice) + Enum.max(slice)
    else
      find(target, data, range + 1)
    end
  end

  # Walking sum implementation
  defp find2(target, data), do: find2(target, data, {0, 0}, 0)

  defp find2(target, data, {min, max}, acc) do
    cond do
      acc == target ->
        slice = Enum.slice(data, min..max)
        Enum.min(slice) + Enum.max(slice)

      acc > target ->
        find2(target, data, {min + 1, max}, acc - Enum.at(data, min))

      acc <= target ->
        find2(target, data, {min, max + 1}, acc + Enum.at(data, max))
    end
  end
end
