defmodule Mix.Tasks.Prepare do
  use Mix.Task

  def run(["19"]) do
    input = File.read!("./inputs/day19.txt")
    {grammar, messages} = Rust.day19_prepare_input(input)

    File.write!("./native/aoc2020rs/src/day19.pest", grammar)
    File.write!("./native/aoc2020rs/src/day19_messages.txt", messages)
  end

  @impl Mix.Task
  def run(_) do
    run(["19"])
  end
end
