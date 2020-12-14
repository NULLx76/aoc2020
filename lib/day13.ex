defmodule Day13 do
  @moduledoc "Day Thirteen of the AoC"

  defp parse(file) do
    File.read!(file)
    |> String.split([",", "\n"], trim: true)
    |> Enum.reject(&(&1 == "x"))
    |> Enum.map(&String.to_integer/1)
  end

  def parse2(file) do
    File.read!(file)
    |> String.split([",", "\n"], trim: true)
    |> Enum.slice(1..-1)
    |> Enum.with_index()
    |> Enum.reject(fn {x, _} -> x == "x" end)
    |> Enum.map(fn {x, y} -> {String.to_integer(x), y} end)
  end

  def find_next_bus(time, bus) do
    id = Enum.min_by(bus, &(&1 - rem(time, &1)))
    wait = id - rem(time, id)
    id * wait
  end

  def part1(file \\ "./inputs/day13.txt") do
    [time | bus] = parse(file)
    find_next_bus(time, bus)
  end

  def part2(file \\ "./inputs/day13.txt") do
    parse2(file)
    |> Enum.map(fn {v, i} -> {v, v - i} end)
    |> ChineseRemainder.chinese_remainder()
  end
end

defmodule ChineseRemainder do
  @moduledoc """
  Chinese Remainder calculator
  Converted from the erlang version at https://rosettacode.org/wiki/Chinese_remainder_theorem#Erlang
  """

  # credo:disable-for-next-line
  def chinese_remainder(congruences) do
    {modulii, residues} = Enum.unzip(congruences)
    mod_pi = List.foldl(modulii, 1, &Kernel.*/2)
    crt_modulii = Enum.map(modulii, &div(mod_pi, &1))

    case calc_inverses(crt_modulii, modulii) do
      nil ->
        nil

      inverses ->
        crt_modulii
        |> Enum.zip(
          residues
          |> Enum.zip(inverses)
          |> Enum.map(fn {a, b} -> a * b end)
        )
        |> Enum.map(fn {a, b} -> a * b end)
        |> Enum.sum()
        |> mod(mod_pi)
    end
  end

  def egcd(_, 0), do: {1, 0}

  def egcd(a, b) do
    {s, t} = egcd(b, rem(a, b))
    {t, s - div(a, b) * t}
  end

  defp mod_inv(a, b) do
    {x, y} = egcd(a, b)

    if a * x + b * y == 1 do
      x
    else
      nil
    end
  end

  defp mod(a, m) do
    x = rem(a, m)

    if x < 0 do
      x + m
    else
      x
    end
  end

  defp calc_inverses([], []), do: []

  defp calc_inverses([n | ns], [m | ms]) do
    case mod_inv(n, m) do
      nil -> nil
      inv -> [inv | calc_inverses(ns, ms)]
    end
  end
end
