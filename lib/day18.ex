defmodule Day18 do
  @moduledoc "Day Eighteen of the AoC"

  defp parse_line([], acc), do: Enum.reverse(acc)

  defp parse_line(["(" | tail], acc) do
    {block, tail} = parse_line(tail, [])
    parse_line(tail, [block | acc])
  end

  defp parse_line([")" | tail], acc), do: {Enum.reverse(acc), tail}

  defp parse_line([head | tail], acc) do
    parse_line(tail, [
      case Integer.parse(head) do
        :error -> head
        {int, ""} -> int
      end
      | acc
    ])
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.replace("(", " ( ")
      |> String.replace(")", " ) ")
      |> String.split(" ", trim: true)
      |> parse_line([])
    end)
  end

  defmodule Part1 do
    def interp([l, "+", r | tail]) do
      interp([interp(l) + interp(r) | tail])
    end

    def interp([l, "*", r | tail]) do
      interp([interp(l) * interp(r) | tail])
    end

    def interp(x) when is_integer(x), do: x
    def interp([x]) when is_integer(x), do: x
  end

  defmodule Part2 do
    def interp([l, "+", r | tail]) do
      interp([interp(l) + interp(r) | tail])
    end

    def interp([l, "*", r | tail]) do
      interp(l) * interp([interp(r) | tail])
    end

    def interp(x) when is_integer(x), do: x
    def interp([x]) when is_integer(x), do: x
  end

  def part1(file \\ "./inputs/day18.txt") do
    File.read!(file)
    |> parse()
    |> Enum.map(&Part1.interp/1)
    |> Enum.sum()
  end

  def part2(file \\ "./inputs/day18.txt") do
    File.read!(file)
    |> parse()
    |> Enum.map(&Part2.interp/1)
    |> Enum.sum()
  end
end
