defmodule DayOne do
  def parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1 do
    input = parse("./inputs/day1.txt")
    adds_to_2020 = fn a, b -> a + b == 2020 end
    [h | _] = for x <- input, y <- input, adds_to_2020.(x, y), do: x * y
    h
  end

  def part2 do
    input = parse("./inputs/day1.txt")
    adds_to_2020 = fn a, b, c -> a + b + c == 2020 end
    [h | _] = for x <- input, y <- input, z <- input, adds_to_2020.(x, y, z), do: x * y * z
    h
  end
end
