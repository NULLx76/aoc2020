defmodule Day25 do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def part1(file \\ "./inputs/day25.txt") do
    {card, door} = File.read!(file) |> parse()
    door_loop = loop_size(door)

    Stream.iterate(1, &transform(&1, card))
    |> Enum.at(door_loop)
  end

  def part2, do: "Free star!"

  defp loop_size(public_key) do
    Stream.iterate(1, &transform(&1, 7))
    |> Stream.with_index()
    |> Enum.find(&elem(&1, 0) == public_key)
    |> elem(1)
  end

  defp transform(value, subject) do
    rem(value * subject, 20_201_227)
  end
end
