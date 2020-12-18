# credo:disable-for-this-file
defmodule Day17 do
  @moduledoc "Day Seventeen of the AoC"

  defmodule Part1 do
    def parse(text) do
      text
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.reduce(MapSet.new(), fn {line, y}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn v, inner_acc ->
          case v do
            {"#", x} -> MapSet.put(inner_acc, {x, y, 0})
            _ -> inner_acc
          end
        end)
      end)
    end

    def step(mapset) do
      {min_x, _, _} = Enum.min_by(mapset, fn {x, _, _} -> x end)
      {max_x, _, _} = Enum.max_by(mapset, fn {x, _, _} -> x end)
      {_, min_y, _} = Enum.min_by(mapset, fn {_, y, _} -> y end)
      {_, max_y, _} = Enum.max_by(mapset, fn {_, y, _} -> y end)
      {_, _, min_z} = Enum.min_by(mapset, fn {_, _, z} -> z end)
      {_, _, max_z} = Enum.max_by(mapset, fn {_, _, z} -> z end)

      for x <- (min_x - 1)..(max_x + 1),
          y <- (min_y - 1)..(max_y + 1),
          z <- (min_z - 1)..(max_z + 1) do
        {x, y, z}
      end
      |> Enum.reduce(MapSet.new(), fn coords, acc ->
        if step_cube(coords, mapset), do: MapSet.put(acc, coords), else: acc
      end)
    end

    defp step_cube(coords, mapset) do
      active? = MapSet.member?(mapset, coords)
      adj_count = count_adj(mapset, coords)

      cond do
        (active? and adj_count == 2) or adj_count == 3 -> true
        not active? and adj_count == 3 -> true
        true -> false
      end
    end

    defp count_adj(mapset, {x, y, z}) do
      for a <- (x - 1)..(x + 1),
          b <- (y - 1)..(y + 1),
          c <- (z - 1)..(z + 1),
          not (a == x and b == y and c == z) do
        {a, b, c}
      end
      |> Enum.count(&MapSet.member?(mapset, &1))
    end
  end

  defmodule Part2 do
    def parse(text) do
      text
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.reduce(MapSet.new(), fn {line, y}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn v, inner_acc ->
          case v do
            {"#", x} -> MapSet.put(inner_acc, {x, y, 0, 0})
            _ -> inner_acc
          end
        end)
      end)
    end

    def step(mapset) do
      {min_x, _, _, _} = Enum.min_by(mapset, fn {x, _, _, _} -> x end)
      {max_x, _, _, _} = Enum.max_by(mapset, fn {x, _, _, _} -> x end)
      {_, min_y, _, _} = Enum.min_by(mapset, fn {_, y, _, _} -> y end)
      {_, max_y, _, _} = Enum.max_by(mapset, fn {_, y, _, _} -> y end)
      {_, _, min_z, _} = Enum.min_by(mapset, fn {_, _, z, _} -> z end)
      {_, _, max_z, _} = Enum.max_by(mapset, fn {_, _, z, _} -> z end)
      {_, _, _, min_w} = Enum.min_by(mapset, fn {_, _, _, w} -> w end)
      {_, _, _, max_w} = Enum.max_by(mapset, fn {_, _, _, w} -> w end)

      for x <- (min_x - 1)..(max_x + 1),
          y <- (min_y - 1)..(max_y + 1),
          z <- (min_z - 1)..(max_z + 1),
          w <- (min_w - 1)..(max_w + 1) do
        {x, y, z, w}
      end
      |> Enum.reduce(MapSet.new(), fn coords, acc ->
        if step_cube(coords, mapset), do: MapSet.put(acc, coords), else: acc
      end)
    end

    defp step_cube(coords, mapset) do
      active? = MapSet.member?(mapset, coords)
      adj_count = count_adj(mapset, coords)

      cond do
        (active? and adj_count == 2) or adj_count == 3 -> true
        not active? and adj_count == 3 -> true
        true -> false
      end
    end

    defp count_adj(mapset, {x, y, z, w}) do
      for a <- (x - 1)..(x + 1),
          b <- (y - 1)..(y + 1),
          c <- (z - 1)..(z + 1),
          d <- (w - 1)..(w + 1),
          not (a == x and b == y and c == z and d == w) do
        {a, b, c, d}
      end
      |> Enum.count(&MapSet.member?(mapset, &1))
    end
  end

  def part1(file \\ "./inputs/day17.txt") do
    File.read!(file)
    |> Part1.parse()
    |> Stream.iterate(&Part1.step/1)
    |> Enum.at(6)
    |> MapSet.size()
  end

  def part2(file \\ "./inputs/day17.txt") do
    File.read!(file)
    |> Part2.parse()
    |> Stream.iterate(&Part2.step/1)
    |> Enum.at(6)
    |> MapSet.size()
  end
end
