defmodule Day16 do
  @moduledoc "Day Sixteen of the AoC"

  def parse_rule(str) do
    str
    |> String.split([": ", " or "])
    |> Enum.slice(1..-1)
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(fn [l | [r]] -> String.to_integer(l)..String.to_integer(r) end)
  end

  def parse(file) do
    [raw_rules | [[raw_ticket] | [raw_nearby]]] =
      file
      |> String.split(["your ticket:", "nearby tickets:"], trim: true)
      |> Enum.map(&String.split(&1, "\n", trim: true))

    rules = raw_rules |> Enum.map(&parse_rule/1)

    ticket =
      raw_ticket
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

  def is_valid_field?(digit, rules), do: Enum.any?(rules, &(digit in &1))

  def is_valid?(ticket, rules) do
    rules = rules |> List.flatten()
    Enum.all?(ticket, &is_valid_field?(&1, rules))
  end

  def ticket_errors(ticket, rules) do
    rules = rules |> List.flatten()

    ticket
    |> Enum.reject(&is_valid_field?(&1, rules))
    |> Enum.sum()
  end

  def is_valid_for_all?(tickets, pos, rule) do
    tickets
    |> Enum.map(&Enum.at(&1, pos))
    |> Enum.all?(&is_valid_field?(&1, rule))
  end

  def remove_rule(combos, rule) do
    combos
    |> Enum.map(&Enum.reject(&1, fn {_, r} -> r == rule end))
    |> Enum.reject(&(&1 == []))
    |> Enum.sort(&(length(&1) < length(&2)))
  end

  def reduce_combos(combos), do: reduce_combos(combos, %{})
  def reduce_combos(combos, found) when length(combos) == 1, do: found

  def reduce_combos(combos, found) do
    {i, r} = hd(hd(combos))
    found = Map.put(found, r, i)

    remove_rule(combos, r)
    |> reduce_combos(found)
  end

  def identify_field(valid_tickets, rules) do
    for i <- 0..length(rules), r <- rules, is_valid_for_all?(valid_tickets, i, r) do
      {i, r}
    end
    |> Enum.chunk_by(fn {pos, _} -> pos end)
    |> reduce_combos()
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
    |> Enum.filter(fn {k, _} -> k in dep_range end)
    |> Enum.reduce(1, fn {_, i}, acc -> acc * Enum.at(ticket, i) end)
  end
end
