defmodule Day14 do
  @moduledoc "Day Fourteen of the AoC"

  defp parse_line("mask = " <> str) do
    mask = str |> String.graphemes() |> Enum.reverse()
    {:mask, mask}
  end

  defp parse_line("mem[" <> str) do
    {addr, rest} = Integer.parse(str)
    "] = " <> val = rest
    {:mem, addr, String.to_integer(val)}
  end

  def parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def mask(mask, val) do
    val
    |> Integer.digits(2)
    |> Enum.reverse()
    |> mask_fixed(mask)
    |> Enum.reverse()
    |> Integer.undigits(2)
  end

  def eval_instr({:mask, mask}, {size, mem, _}, _), do: {size, mem, mask}

  def eval_instr({:mem, addr, val}, {size, mem, mask}, :one) do
    {size, Map.put(mem, addr, mask(mask, val)), mask}
  end

  def eval_instr({:mem, addr, val}, {size, memory, mask}, :two) do
    {size, assign_with_mask(memory, addr, mask, val), mask}
  end

  def assign_with_mask(memory, addr, mask, val) do
    addr
    |> Integer.digits(2)
    |> Enum.reverse()
    |> mask_fixed(mask)
    |> mask_float(mask)
    |> List.flatten()
    |> Enum.reduce(memory, &Map.put(&2, &1, val))
  end

  def mask_fixed(digits, mask) do
    for {digit, i} <- Enum.with_index(mask) do
      case digit do
        "0" -> Enum.at(digits, i) || 0
        "1" -> 1
        _ -> Enum.at(digits, i) || 0
      end
    end
  end

  def mask_float(addr_digits, mask) do
    case Enum.find_index(mask, &(&1 == "X")) do
      nil ->
        addr_digits
        |> Enum.reverse()
        |> Integer.undigits(2)

      index ->
        [
          mask_float(
            List.replace_at(addr_digits, index, 0),
            List.replace_at(mask, index, "0")
          ),
          mask_float(
            List.replace_at(addr_digits, index, 1),
            List.replace_at(mask, index, "1")
          )
        ]
    end
  end

  def eval(instr, part) do
    Enum.reduce(instr, {36, %{}, []}, &eval_instr(&1, &2, part))
    |> elem(1)
    |> Map.values()
    |> Enum.sum()
  end

  def part1(file \\ "./inputs/day14.txt") do
    parse(file)
    |> eval(:one)
  end

  def part2(file \\ "./inputs/day14.txt") do
    parse(file)
    |> eval(:two)
  end
end
