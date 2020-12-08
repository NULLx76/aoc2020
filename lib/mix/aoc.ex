defmodule Mix.Tasks.Aoc do
  @shortdoc "print aoc days"
  @moduledoc "This tasks run all or specific days and prints them"

  use Mix.Task

  @spec pad_zero(integer()) :: binary()
  defp pad_zero(day) do
    if day < 10 do
      "0" <> Integer.to_string(day)
    else
      Integer.to_string(day)
    end
  end

  @spec run_day(integer) :: :ok | :error
  def run_day(day) do
    mod = "Elixir.Day" <> pad_zero(day)

    try do
      mod = String.to_existing_atom(mod)

      Mix.shell().info("Day #{day}:")
      Mix.shell().info(" p1: #{apply(mod, :part1, [])}")
      Mix.shell().info(" p2: #{apply(mod, :part2, [])}")
      :ok
    rescue
      ArgumentError -> :error
    end
  end

  @impl Mix.Task
  def run(args) do
    if length(args) == 1 do
      case Integer.parse(hd(args)) do
        {day, _} ->
          if run_day(day) != :ok do
            Mix.shell().error("Invalid day: \"#{day}\"")
          end

        :error ->
          Mix.shell().error("Invalid integer: \"#{hd(args)}\"")
      end
    else
      for x <- 1..25, do: run_day(x)
    end
  end
end
