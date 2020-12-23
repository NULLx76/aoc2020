defmodule Day23 do
  def parse(input) do
    input
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  def find_destination(current, a, b, c, max) do
    cond do
      (n = cycle(current - 1, max)) not in [a, b, c] -> n
      (n = cycle(current - 2, max)) not in [a, b, c] -> n
      (n = cycle(current - 3, max)) not in [a, b, c] -> n
      true -> cycle(current - 4, max)
    end
  end

  defp cycle(n, _) when n > 0, do: n
  defp cycle(n, max), do: max - abs(n)

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

    def create_linkedmap(original_list, rest_start..rest_end) do
      # Convert original list to linked tuples so that list[i] links to list[i+1]
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

      # Concat and create map
      [start, middle, last]
      |> Stream.concat()
      |> Map.new()
    end

    def move({curr, linkedmap}) do
      a = Map.get(linkedmap, curr)
      b = Map.get(linkedmap, a)
      c = Map.get(linkedmap, b)
      next = Map.get(linkedmap, c)

      dest = Day23.find_destination(curr, a, b, c, @max)
      after_destination = Map.get(linkedmap, dest)

      next_map =
        linkedmap
        |> Map.put(curr, next)
        |> Map.put(dest, a)
        |> Map.put(c, after_destination)

      {next, next_map}
    end

    def run(data) do
      linkedmap = create_linkedmap(data, 10..@max)

      result_map =
        {List.first(data), linkedmap}
        |> Stream.iterate(&move/1)
        |> Enum.at(@moves)
        |> elem(1)

      s1 = result_map[1]
      s2 = result_map[s1]

      s1 * s2
    end
  end

  def part2(file \\ "./inputs/day23.txt") do
    File.read!(file)
    |> parse()
    |> Part2.run()
  end
end
