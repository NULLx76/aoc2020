defmodule Day02 do
  @moduledoc "Day Two of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
  end

  def is_valid?(line) do
    [min, max, char, password] = String.split(line, ["-", " ", ":"], trim: true)
    [c | _] = to_charlist(char)
    count = Enum.count(to_charlist(password), &(&1 == c))

    count >= String.to_integer(min) && count <= String.to_integer(max)
  end

  def part1(file \\ "./inputs/day02.txt") do
    parse(file)
    |> Enum.count(&is_valid?/1)
  end

  def is_valid2?(line) do
    [pos1, pos2, char, password] = String.split(line, ["-", " ", ":"], trim: true)
    at_pos1? = String.at(password, String.to_integer(pos1) - 1) == char
    at_pos2? = String.at(password, String.to_integer(pos2) - 1) == char

    at_pos1? != at_pos2?
  end

  def part2(file \\ "./inputs/day02.txt") do
    parse(file)
    |> Enum.count(&is_valid2?/1)
  end
end
