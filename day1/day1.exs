defmodule DayOne do
    def parse(file) do
        f = File.read!(file)
            |> String.trim()
            |> String.split("\n")

        Enum.map(f, &String.to_integer/1)
    end
    def part1 do
        input = parse("day1.txt")
        adds_to_2020 = fn a,b -> a + b == 2020 end
        res = for x <- input, y <-input, adds_to_2020.(x,y), do: x * y
        hd(res)
    end
    def part2 do
        input = parse("day1.txt")
        adds_to_2020 = fn a,b,c -> a + b + c == 2020 end
        res = for x <- input, y <-input, z <- input, adds_to_2020.(x,y,z), do: x * y * z
        hd(res)
    end
end

IO.puts("part1: #{DayOne.part1()}")
IO.puts("part2: #{DayOne.part2()}")