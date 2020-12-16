defmodule Day16 do
  @moduledoc "Day Sixteen of the AoC"

  def parse_range(str) do
    [l | [r]] =
      str
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    l..r
  end

  def parse_rule(str) do
    str
    |> String.split([": ", " or "])
    |> Enum.slice(1..-1)
    |> Enum.map(&parse_range/1)
  end

  def parse(file) do
    [raw_rules | [raw_ticket | [raw_nearby]]] =
      file
      |> String.split(["your ticket:", "nearby tickets:"], trim: true)
      |> Enum.map(&String.split(&1, "\n", trim: true))

    rules = raw_rules |> Enum.map(&parse_rule/1)

    ticket =
      raw_ticket
      |> hd()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    nearby =
      raw_nearby
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(&Enum.map(&1, fn s -> String.to_integer(s) end))

    {rules, ticket, nearby}
  end

  def parse_departure_to_ranges(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.filter(&String.contains?(&1, "departure"))
    |> Enum.map(&parse_rule/1)
  end

  def is_valid_field?(digit, rules), do: Enum.any?(rules, fn rule -> digit in rule end)

  def is_valid?(ticket, rules) do
    rules = rules |> List.flatten()

    ticket
    |> Enum.all?(&is_valid_field?(&1, rules))
  end

  def ticket_errors(ticket, rules) do
    rules = rules |> List.flatten()

    ticket
    |> Enum.reject(&is_valid_field?(&1, rules))
    |> Enum.sum()
  end

  def is_valid_for_all(tickets, pos, rule) do
    tickets
    |> Enum.map(&Enum.at(&1, pos))
    |> Enum.all?(&is_valid_field?(&1, rule))
  end

  def identify_field(valid_tickets, rules) do
    combos =
      for i <- 0..length(rules),
          r <- rules,
          is_valid_for_all(valid_tickets, i, r),
          do: {i, r}

    Enum.chunk_by(combos, fn {pos, _} -> pos end)
  end

  def remove_rule(combos, rule) do
    combos
    |> Enum.map(&Enum.reject(&1, fn {_, r} -> r == rule end))
    |> Enum.reject(&(&1 == []))
  end

  def reduce_combos(combos, found \\ %{}) do
    combos = Enum.sort(combos, fn a, b -> length(a) < length(b) end)

    {i, r} = hd(hd(combos))

    found = Map.put(found, r, i)

    case remove_rule(combos, r) do
      [] -> found
      x -> reduce_combos(x, found)
    end
  end

  def part1(file \\ "./inputs/day16.txt") do
    file = File.read!(file)
    {rules, _, nearby} = parse(file)

    nearby
    |> Enum.map(&ticket_errors(&1, rules))
    |> Enum.sum()
  end

  def part2(file \\ "./inputs/day16.txt") do
    file = File.read!(file)
    dep_range = parse_departure_to_ranges(file)
    {rules, ticket, nearby} = parse(file)

    nearby
    |> Enum.filter(&is_valid?(&1, rules))
    |> identify_field(rules)
    |> reduce_combos()
    |> Enum.filter(fn {k, _} -> k in dep_range end)
    |> Enum.reduce(1, fn {_, i}, acc -> acc * Enum.at(ticket, i) end)
  end
end
