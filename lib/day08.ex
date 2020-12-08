defmodule Day08.State do
  @moduledoc "Internal state for Day08's interpreter"
  defstruct code: [:nop, 0], pc: 0, acc: 0, vis: []
end

defmodule Day08 do
  @moduledoc "Day Eight of the AoC"
  alias Day08.State

  # All valid instructions
  [:nop, :acc, :jmp]

  def parse_instr(line) do
    [instr, data] = String.split(line)
    {String.to_existing_atom(instr), String.to_integer(data)}
  end

  def parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instr/1)
  end

  def run_instr(%{acc: a, pc: pc, vis: v} = s, {:acc, n}),
    do: %{s | pc: pc + 1, vis: [pc | v], acc: a + n}

  def run_instr(%{pc: pc, vis: v} = s, {:nop, _}), do: %{s | pc: pc + 1, vis: [pc | v]}
  def run_instr(%{pc: pc, vis: v} = s, {:jmp, n}), do: %{s | pc: pc + n, vis: [pc | v]}
  def run_instr(%{acc: a}, _), do: {a, :exit}

  def execute(%{acc: a, code: c, pc: l, vis: v} = s) do
    if l in v do
      {a, :loop}
    else
      case run_instr(s, Enum.at(c, l)) do
        {a, :exit} -> {a, :exit}
        x -> execute(Map.merge(s, x))
      end
    end
  end

  def part1(file \\ "./inputs/day8.txt") do
    code = parse(file)
    state = %State{code: code}
    {a, _} = execute(state)
    a
  end

  def part2(file \\ "./inputs/day8.txt") do
    code = parse(file)
    mutate(code, 0)
  end

  defp run_mut(mutated, code, line) do
    case execute(%State{code: mutated}) do
      {_, :loop} -> mutate(code, line + 1)
      {a, :exit} -> a
    end
  end

  def mutate(code, line) do
    case Enum.at(code, line) do
      {:jmp, n} ->
        List.replace_at(code, line, {:nop, n})
        |> run_mut(code, line)

      {:nop, n} ->
        List.replace_at(code, line, {:jmp, n})
        |> run_mut(code, line)

      _ ->
        mutate(code, line + 1)
    end
  end
end
