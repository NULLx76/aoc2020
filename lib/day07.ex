defmodule Day07 do
  @moduledoc "Day Seven of the AoC"

  @bag_re ~r/bags?\.?/
  @num_re ~r/\d+/

  @spec strip_bag(binary) :: binary
  defp strip_bag(bag) do
    bag
    |> String.replace(@bag_re, "")
    |> String.replace(@num_re, "")
    |> String.trim()
  end

  @spec strip_contained_bag(binary) :: {binary, integer}
  defp strip_contained_bag(bag) do
    n = Regex.run(@num_re, bag, capture: :first)

    if n == nil do
      {strip_bag(bag), 0}
    else
      {strip_bag(bag), String.to_integer(hd(n))}
    end
  end

  @spec parse_line(binary) :: %{binary => [binary]}
  defp parse_line(line) do
    [bag | [contains]] = String.split(line, "contain", trim: true)

    contained = String.split(contains, ",", trim: true) |> Enum.map(&strip_contained_bag/1)

    %{strip_bag(bag) => contained}
  end

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, &Map.merge/2)
  end

  defp can_contain?(map, {bag, _}, find), do: can_contain?(map, bag, find)

  defp can_contain?(map, bag, find) do
    case Map.pop(map, bag) do
      {nil, _} ->
        false

      {contains, new_map} ->
        if Enum.find(contains, &(elem(&1, 0) == find)) != nil do
          true
        else
          Enum.any?(contains, &can_contain?(new_map, &1, find))
        end
    end
  end

  defp count_nested(map, bag) do
    case Map.pop(map, bag) do
      {nil, _} ->
        0

      {contains, new_map} ->
        count =
          contains
          |> Enum.map(fn {bag, n} -> n * count_nested(new_map, bag) end)
          |> Enum.sum()

        count + 1
    end
  end

  def part1(file \\ "./inputs/day7.txt") do
    data = parse(file)

    data
    |> Enum.filter(&can_contain?(data, &1, "shiny gold"))
    |> Enum.count()
  end

  def part2(file \\ "./inputs/day7.txt") do
    count_nested(parse(file), "shiny gold") - 1
  end
end
