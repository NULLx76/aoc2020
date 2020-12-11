defmodule Day11 do
  @moduledoc "Day Eleven of the AoC"

  @dirs [{-1, 1}, {0, 1}, {1, 1}, {-1, 0}, {1, 0}, {-1, -1}, {0, -1}, {1, -1}]

  def parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      Enum.into(row, Map.new(), fn {el, x} -> {{x, y}, el} end)
    end)
    |> Enum.reduce(&Map.merge/2)
  end

  def count_neigh(map, {x, y}) do
    @dirs
    |> Enum.map(fn {dx, dy} ->
      Map.get(map, {x + dx, y + dy})
    end)
    |> Enum.count(&(&1 == "#"))
  end

  def visible(map, {x, y}, {dx, dy} = dir) do
    seat = Map.get(map, {x, y})

    case seat do
      nil -> false
      "#" -> true
      "L" -> false
      _ -> visible(map, {x + dx, y + dy}, dir)
    end
  end

  def count_vis(map, {x, y}) do
    Enum.count(@dirs, fn {dx, dy} ->
      visible(map, {x + dx, y + dy}, {dx, dy})
    end)
  end

  def tick_seat(map, coord, seat) do
    cond do
      seat == "L" && count_neigh(map, coord) == 0 -> "#"
      seat == "#" && count_neigh(map, coord) >= 4 -> "L"
      true -> seat
    end
  end

  def tick_seat_vis(map, coord, seat) do
    cond do
      seat == "L" && count_vis(map, coord) == 0 -> "#"
      seat == "#" && count_vis(map, coord) >= 5 -> "L"
      true -> seat
    end
  end

  def cycle(map, ftick) do
    next =
      Enum.map(map, fn {coord, seat} ->
        {coord, ftick.(map, coord, seat)}
      end)
      |> Enum.into(%{})

    if next == map do
      map
    else
      cycle(next, ftick)
    end
  end

  def part1(file \\ "./inputs/day11.txt") do
    parse(file)
    |> cycle(&tick_seat/3)
    |> Enum.count(fn {_, v} -> v == "#" end)
  end

  def part2(file \\ "./inputs/day11.txt") do
    parse(file)
    |> cycle(&tick_seat_vis/3)
    |> Enum.count(fn {_, v} -> v == "#" end)
  end
end
