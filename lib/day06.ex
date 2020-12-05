defmodule Day06 do
  @moduledoc "Day Six of the AoC"

  def parse(file \\ "./inputs/day6.txt") do
    File.read!(file)
    |> String.split("\n", trim: true)
  end

  def part1, do: nil
end
