defmodule Day04.Validator do
  @moduledoc "Day04 Validate function extracted into a module"

  @spec has_valid_keys?(Map) :: boolean
  def has_valid_keys?(passport) do
    # cid ommited
    ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    |> Enum.all?(&Map.has_key?(passport, &1))
  end

  @spec valid?({binary, binary}) :: boolean
  def valid?({"hgt", v}) do
    case String.split_at(v, -2) do
      {h, "cm"} -> String.to_integer(h) in 150..193
      {h, "in"} -> String.to_integer(h) in 59..76
      _ -> false
    end
  end

  def valid?({"ecl", v}), do: v in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  def valid?({"hcl", v}), do: Regex.match?(~r/^#[0-9a-f]{6}$/, v)
  def valid?({"byr", v}), do: String.to_integer(v) in 1920..2002
  def valid?({"iyr", v}), do: String.to_integer(v) in 2010..2020
  def valid?({"eyr", v}), do: String.to_integer(v) in 2020..2030
  def valid?({"pid", v}), do: String.length(v) == 9
  def valid?({"cid", _}), do: true
  def valid?({_, _}), do: false
end

defmodule Day04 do
  @moduledoc "Day Four of the AoC"
  import Day04.Validator

  @spec parse_passport([binary]) :: Map
  def parse_passport(passport) do
    passport
    |> Enum.map(&String.split(&1, ":", trim: true))
    |> Enum.into(%{}, fn [a, b] -> {a, b} end)
  end

  @spec parse(binary) :: [Map]
  def parse(file) do
    File.read!(file)
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, [" ", "\n"], trim: true))
    |> Enum.map(&parse_passport/1)
  end

  def part1(file \\ "./inputs/day4.txt") do
    parse(file)
    |> Enum.count(&has_valid_keys?/1)
  end

  def part2(file \\ "./inputs/day4.txt") do
    parse(file)
    |> Enum.filter(&has_valid_keys?/1)
    |> Enum.count(&Enum.all?(&1, fn x -> valid?(x) end))
  end
end
