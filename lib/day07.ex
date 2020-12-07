defmodule Day07 do
  @moduledoc "Day Seven of the AoC"

  @shiny_gold "shiny gold"

  @bag_re ~r/(bags?\.?|\d+)/
  defp strip_bag(bag), do: String.replace(bag, @bag_re, "") |> String.trim()

  defp parse_contained_bag(bag) do
    case bag |> String.trim() |> String.first() |> Integer.parse() do
      :error -> {:none, 0}
      {n, _} -> {strip_bag(bag), n}
    end
  end

  defp parse_line(line) do
    [bag | [contains]] = String.split(line, " contain ")
    contained = String.split(contains, ", ") |> Enum.map(&parse_contained_bag/1)
    {strip_bag(bag), contained}
  end

  defp parse(file), do: File.stream!(file) |> Enum.into(%{}, &parse_line/1)

  defp can_contain?(_, {:none, 0}, _), do: false
  defp can_contain?(_, {bag, _}, find) when bag == find, do: true

  defp can_contain?(map, {bag, _}, find) do
    Map.get(map, bag, none: 0)
    |> Enum.any?(&can_contain?(map, &1, find))
  end

  defp count_nested(_, :none), do: 0

  defp count_nested(map, bag) do
    Map.get(map, bag, none: 0)
    |> Enum.reduce(1, fn {bag, n}, acc -> count_nested(map, bag) * n + acc end)
  end

  @spec part1(binary) :: integer
  def part1(file \\ "./inputs/day7.txt") do
    data = parse(file)
    Enum.count(data, &can_contain?(data, &1, @shiny_gold)) - 1
  end

  @spec part2(binary) :: integer
  def part2(file \\ "./inputs/day7.txt") do
    data = parse(file)
    count_nested(data, @shiny_gold) - 1
  end
end
