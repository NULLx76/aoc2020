defmodule Rust do
  use Rustler, otp_app: :aoc2020, crate: "aoc2020rs"

  # When the NIFs are loaded, it will override these functions.

  def day19_part1, do: :erlang.nif_error(:nif_not_loaded)
  def day19_prepare_input(_input), do: :erlang.nif_error(:nif_not_loaded)
end
