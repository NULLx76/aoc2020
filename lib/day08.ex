defmodule Day08.Bootloader do
  @moduledoc "Day eight Bootloader"

  @type instruction :: {:nop | :acc | :jmp, integer()}
  @type code :: [instruction()]

  defp parse_instr([instr, data]) do
    {String.to_existing_atom(instr), String.to_integer(data)}
  end

  @spec parse(binary) :: code()
  def parse(file) do
    File.stream!(file)
    |> Stream.map(&String.split/1)
    |> Stream.map(&parse_instr/1)
    |> Enum.into([])
  end

  defmodule State do
    @moduledoc "Internal state for Day08's interpreter"
    defstruct code: nil, pc: 0, acc: 0, vis: []
  end

  @spec exec(%State{}, nil | instruction()) :: {integer(), :exit} | %State{}
  def exec(s, nil), do: {s.acc, :exit}
  def exec(s, {:nop, _}), do: %State{s | pc: s.pc + 1, vis: [s.pc | s.vis]}
  def exec(s, {:jmp, n}), do: %State{s | pc: s.pc + n, vis: [s.pc | s.vis]}
  def exec(s, {:acc, n}), do: %State{s | pc: s.pc + 1, vis: [s.pc | s.vis], acc: s.acc + n}

  def run(code) when is_list(code), do: run(%State{code: code})

  def run(s) do
    if s.pc in s.vis do
      {s.acc, :loop}
    else
      case exec(s, Enum.at(s.code, s.pc)) do
        {a, :exit} -> {a, :exit}
        x -> run(x)
      end
    end
  end

  @spec mutate(code(), number()) :: code()
  defp mutate(code, line) do
    case Enum.at(code, line) do
      {:jmp, n} -> List.replace_at(code, line, {:nop, n})
      {:nop, n} -> List.replace_at(code, line, {:jmp, n})
      _ -> code
    end
  end

  @spec run_mutate(code(), integer()) :: integer()
  def run_mutate(code, line \\ 0) do
    case run(mutate(code, line)) do
      {_, :loop} -> run_mutate(code, line + 1)
      {a, :exit} -> a
    end
  end
end

defmodule Day08 do
  @moduledoc "Day Eight of the AoC"
  alias Day08.Bootloader

  @spec part1(binary) :: integer
  def part1(file \\ "./inputs/day08.txt") do
    code = Bootloader.parse(file)
    {acc, :loop} = Bootloader.run(code)
    acc
  end

  @spec part2(binary) :: integer
  def part2(file \\ "./inputs/day08.txt") do
    code = Bootloader.parse(file)
    Bootloader.run_mutate(code)
  end
end
