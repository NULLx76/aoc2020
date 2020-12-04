defmodule Day04 do
  @moduledoc "Day Four of the AoC"

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

  @spec is_valid?(Map) :: boolean
  def is_valid?(passport) do
    # cid ommited
    ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    |> Enum.all?(&Map.has_key?(passport, &1))
  end

  defp in_bounds?(str, low, high) do
    String.to_integer(str) >= low and String.to_integer(str) <= high
  end

  defp is_valid_hgt(v) do
    val = String.slice(v, 0..-3)
    suffix = String.slice(v, -2..-1)

    case suffix do
      "cm" -> in_bounds?(val, 150, 193)
      "in" -> in_bounds?(val, 59, 76)
      _ -> false
    end
  end

  def is_valid2?(passport) do
    Enum.all?(passport, fn x ->
      case x do
        {"ecl", v} ->
          ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
          |> Enum.member?(v)

        {"hgt", v} ->
          is_valid_hgt(v)

        {"hcl", v} ->
          Regex.match?(~r/^#[0-9a-f]{6}$/, v)

        {"byr", v} ->
          in_bounds?(v, 1920, 2002)

        {"iyr", v} ->
          in_bounds?(v, 2010, 2020)

        {"eyr", v} ->
          in_bounds?(v, 2020, 2030)

        {"pid", v} ->
          String.length(v) == 9

        _ ->
          true
      end
    end)
  end

  def part1 do
    part1("./inputs/day4.txt")
  end

  def part1(file) do
    parse(file)
    |> Enum.count(&is_valid?/1)
  end

  def part2 do
    part2("./inputs/day4.txt")
  end

  def part2(file) do
    parse(file)
    |> Enum.filter(&is_valid?/1)
    |> Enum.count(&is_valid2?/1)
  end
end
