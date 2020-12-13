defmodule Day12 do
  @moduledoc "Day twelve of the AoC"

  # Had problems with elixir optimizing away certain atoms
  # So just make a map
  @lookup %{
    "N" => :N,
    "E" => :E,
    "S" => :S,
    "W" => :W,
    "F" => :F,
    "L" => :L,
    "R" => :R
  }

  defp parse_instr(instr) do
    {op, n} = String.split_at(instr, 1)
    {Map.get(@lookup, op), String.to_integer(n)}
  end

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instr/1)
  end

  def manhattan({x, y}), do: abs(x) + abs(y)

  defmodule Part1 do
    @moduledoc "Day twelve part 1 of the AoC"

    def move([], pos, _), do: pos
    def move([{:N, n} | rest], {x, y}, f), do: move(rest, {x, y + n}, f)
    def move([{:S, n} | rest], {x, y}, f), do: move(rest, {x, y - n}, f)
    def move([{:E, n} | rest], {x, y}, f), do: move(rest, {x + n, y}, f)
    def move([{:W, n} | rest], {x, y}, f), do: move(rest, {x - n, y}, f)
    def move([{:F, n} | rest], {x, y}, f), do: move([{f, n} | rest], {x, y}, f)
    def move([{:L, n} | rest], {x, y}, f), do: move(rest, {x, y}, rotate_left(n, f))
    def move([{:R, n} | rest], {x, y}, f), do: move(rest, {x, y}, rotate_right(n, f))

    @dirs [:N, :E, :S, :W]
    def rotate_right(n, f) do
      q = div(n, 90)
      i = Enum.find_index(@dirs, &(&1 == f))
      Enum.at(@dirs, rem(i + q, 4))
    end

    def rotate_left(n, f) do
      q = div(n, 90)
      i = Enum.find_index(@dirs, &(&1 == f))
      Enum.at(@dirs, rem(i - q, 4))
    end

    def run(list) do
      move(list, {0, 0}, :E)
      |> Day12.manhattan()
    end
  end

  defmodule Part2 do
    @moduledoc "Day twelve part 2 of the AoC"

    def move([], boat, _), do: boat
    def move([{:N, n} | rest], boat, {x, y}), do: move(rest, boat, {x, y + n})
    def move([{:S, n} | rest], boat, {x, y}), do: move(rest, boat, {x, y - n})
    def move([{:E, n} | rest], boat, {x, y}), do: move(rest, boat, {x + n, y})
    def move([{:W, n} | rest], boat, {x, y}), do: move(rest, boat, {x - n, y})

    def move([{:F, n} | rest], {x, y}, {wx, wy}),
      do: move(rest, {x + wx * n, y + wy * n}, {wx, wy})

    def move([{:L, n} | rest], boat, wp), do: move(rest, boat, rotate_left(wp, n))
    def move([{:R, n} | rest], boat, wp), do: move(rest, boat, rotate_right(wp, n))

    def rotate_left(wp, 0), do: wp
    def rotate_left({wx, wy}, degrees), do: rotate_left({-wy, wx}, degrees - 90)

    def rotate_right(wp, 0), do: wp
    def rotate_right({wx, wy}, degrees), do: rotate_right({wy, -wx}, degrees - 90)

    def run(list) do
      move(list, {0, 0}, {10, 1})
      |> Day12.manhattan()
    end
  end

  def part1(file \\ "./inputs/day12.txt") do
    parse(file)
    |> Part1.run()
  end

  def part2(file \\ "./inputs/day12.txt") do
    parse(file)
    |> Part2.run()
  end
end
