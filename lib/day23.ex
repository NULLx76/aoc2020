defmodule Day23 do
  def parse(input) do
    input
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  def find_destination(current, a, b, c, max) do
    cond do
      (n = wrap(current - 1, max)) not in [a, b, c] -> n
      (n = wrap(current - 2, max)) not in [a, b, c] -> n
      (n = wrap(current - 3, max)) not in [a, b, c] -> n
      true -> wrap(current - 4, max)
    end
  end

  defp wrap(n, _) when n > 0, do: n
  defp wrap(n, max), do: max - abs(n)

  defmodule Part1 do
    @moves 100

    def move([current_cup, a, b, c | rest] = list) do
      dest = Day23.find_destination(current_cup, a, b, c, Enum.max(list))
      {head, tail} = rest |> Enum.split_while(&(&1 != dest))
      Enum.concat([head, [dest, a, b, c], Enum.drop(tail, 1), [current_cup]])
    end

    def cups_after_one(cups) do
      {head, tail} = Enum.split_while(cups, &(&1 != 1))
      Enum.drop(tail, 1) ++ head
    end

    def run(list) do
      list
      |> Stream.iterate(&move/1)
      |> Enum.at(@moves)
      |> cups_after_one
      |> Integer.undigits()
    end
  end

  def part1(file \\ "./inputs/day23.txt") do
    File.read!(file)
    |> parse()
    |> Part1.run()
  end

  defmodule Part2 do
    @max 1_000_000
    @moves 10_000_000

    def create_tab(original_list, rest_start..rest_end) do
      table = :ets.new(:cups, [:set])

      start =
        original_list
        |> List.insert_at(-1, rest_start)
        |> Enum.chunk_every(2, 1, :discard)
        |> Enum.map(&List.to_tuple/1)

      # Generate it for the next n
      middle =
        rest_start..(rest_end - 1)
        |> Stream.map(fn n -> {n, n + 1} end)

      # Link last to first
      last = [{rest_end, List.first(original_list)}]

      # Concat and insert
      items = [start, middle, last] |> Enum.concat()
      :ets.insert(table, items)

      table
    end

    def move({curr, tab}) do
      [{^curr, a}] = :ets.lookup(tab, curr)
      [{^a, b}] = :ets.lookup(tab, a)
      [{^b, c}] = :ets.lookup(tab, b)
      [{^c, next}]  = :ets.lookup(tab, c)

      dest = Day23.find_destination(curr, a, b, c, @max)
      [{^dest, after_destination}] = :ets.lookup(tab, dest)

      :ets.insert(tab, {curr, next})
      :ets.insert(tab, {dest, a})
      :ets.insert(tab, {c, after_destination})

      {next, tab}
    end

    def run(data) do
      tab = create_tab(data, 10..@max)

      {List.first(data), tab}
      |> Stream.iterate(&move/1)
      |> Enum.at(@moves)

      [{1, s1}] = :ets.lookup(tab,1)
      [{^s1, s2}] = :ets.lookup(tab, s1)

      s1 * s2
    end
  end

  def part2(file \\ "./inputs/day23.txt") do
    File.read!(file)
    |> parse()
    |> Part2.run()
  end
end
