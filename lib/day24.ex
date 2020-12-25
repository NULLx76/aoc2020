defmodule Day24 do

  # credo:disable-for-next-line
  def parse_line(line) do
    case line do
      "e" <> rest -> [:e | parse_line(rest)]
      "se" <> rest -> [:se | parse_line(rest)]
      "sw" <> rest -> [:sw | parse_line(rest)]
      "w" <> rest -> [:w | parse_line(rest)]
      "nw" <> rest -> [:nw | parse_line(rest)]
      "ne" <> rest -> [:ne | parse_line(rest)]
      "" -> []
    end
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def flip_tile(directions, black_tiles) do
    loc = Enum.reduce(directions, {0, 0}, &move/2)

    if MapSet.member?(black_tiles, loc) do
      MapSet.delete(black_tiles, loc)
    else
      MapSet.put(black_tiles, loc)
    end
  end

  def move(:e, {q, r}), do: {q + 1, r}
  def move(:se, {q, r}), do: {q, r + 1}
  def move(:sw, {q, r}), do: {q - 1, r + 1}
  def move(:w, {q, r}), do: {q - 1, r}
  def move(:nw, {q, r}), do: {q, r - 1}
  def move(:ne, {q, r}), do: {q + 1, r - 1}

  def part1(file \\ "./inputs/day24.txt") do
    File.read!(file)
    |> parse()
    |> Enum.reduce(MapSet.new(), &flip_tile/2)
    |> MapSet.size()
  end

  def part2(file \\ "./inputs/day24.txt") do
    File.read!(file)
    |> Day24.parse()
    |> Enum.reduce(MapSet.new(), &flip_tile/2)
    |> Stream.iterate(&one_day/1)
    |> Stream.drop(100)
    |> Enum.take(1)
    |> hd
    |> Enum.count()
  end

  defp one_day(black) do
    new_black =
      white_tiles(black)
      |> Enum.filter(&(count_black_neigh(black, &1) == 2))

    black
    |> Enum.filter(fn x ->
      n = count_black_neigh(black, x)
      not (n === 0 or n > 2)
    end)
    |> Enum.concat(new_black)
    |> MapSet.new()
  end

  defp white_tiles(black_tiles) do
    black_tiles
    |> Enum.flat_map(&neighbours/1)
    |> Enum.uniq()
  end

  defp count_black_neigh(black_tiles, location) do
    neighbours(location)
    |> Enum.count(&MapSet.member?(black_tiles, &1))
  end

  defp neighbours(location) do
    [:e, :se, :sw, :w, :nw, :ne]
    |> Enum.map(&move(&1, location))
  end
end
