defmodule Python do
  defmodule Helper do
    def python_instance(path) when is_list(path) do
      {:ok, pid} = :python.start([{:python_path, to_charlist(path)}])
      pid
    end

    def python_instance(_) do
      {:ok, pid} = :python.start()
      pid
    end

    def call_python(pid, module, function, arguments \\ []) do
      pid
      |> :python.call(module, function, arguments)
    end

    def default_instance do
      path = [:code.priv_dir(:aoc2020), "python"] |> Path.join()
      python_instance(to_charlist(path))
    end
  end

  def day19_part2(input) do
    Helper.default_instance()
    |> Helper.call_python(:day19, :part2, [input])
  end
end
