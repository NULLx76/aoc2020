ExUnit.start()

defmodule TestHelper do
  @doc """
  ## Example
      iex> TestHelper.time "Some name", fn -> true end
      Some name takes 0.07ms to execute
      0.07
  """
  def time(name, f, n \\ 2048) do
    time = Time.utc_now()

    for _ <- 0..n do
      f.()
    end

    exec_time = Float.round(Time.diff(Time.utc_now(), time, :microsecond) / n, 2)
    IO.puts("\n#{name} takes #{exec_time}us to execute")
    exec_time
  end
end
