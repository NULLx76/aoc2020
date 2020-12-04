defmodule Day01 do
  @moduledoc "Day One of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  @spec part1(binary) :: non_neg_integer
  def part1(file \\ "./inputs/day1.txt") do
    input = parse(file)
    adds_to_2020? = &(&1 + &2 == 2020)
    res = for x <- input, y <- input, adds_to_2020?.(x, y), do: x * y
    hd(res)
  end

  @spec part2(binary) :: non_neg_integer
  def part2(file \\ "./inputs/day1.txt") do
    input = parse(file)
    adds_to_2020? = fn a, b, c -> a + b + c == 2020 end
    [h | _] = for x <- input, y <- input, z <- input, adds_to_2020?.(x, y, z), do: x * y * z
    h
  end
end
