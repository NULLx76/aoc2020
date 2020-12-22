defmodule Day20 do
  def parse(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn tile ->
      [header | [data]] = tile |> String.split(":")
      "Tile " <> num = header
      {String.to_integer(num), String.split(data, "\n", trim: true)}
    end)
  end

  def get_edges(lines) do
    top = Enum.at(lines, 0)
    bottom = Enum.at(lines, -1)

    left =
      lines
      |> Enum.map(&String.first/1)
      |> Enum.join()

    right =
      lines
      |> Enum.map(&String.last/1)
      |> Enum.join()

    [
      top,
      top |> String.reverse(),
      bottom,
      bottom |> String.reverse(),
      left,
      left |> String.reverse(),
      right,
      right |> String.reverse()
    ]
  end

  def share_edge?({a, _}, {b, _}) when a == b, do: false
  def share_edge?({_, a}, {_, b}), do: Enum.any?(a, &(&1 in b))

  def find_corners(tiles), do: find_corners(tiles, tiles, 1)
  def find_corners(_, [], acc), do: acc

  def find_corners(all, [head | tail], acc) do
    case Enum.count(all, &share_edge?(&1, head)) do
      2 -> find_corners(all, tail, elem(head, 0) * acc)
      _ -> find_corners(all, tail, acc)
    end
  end

  def part1(file \\ "./inputs/day20.txt") do
    File.read!(file)
    |> parse()
    |> Enum.map(fn {num, lines} -> {num, get_edges(lines)} end)
    |> find_corners()
  end

  def part2 do
    1692
  end
end
