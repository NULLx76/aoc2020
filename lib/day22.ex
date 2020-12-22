defmodule Day22 do
  def parse(input) do
    [player1 | [player2 | []]] =
      input
      |> String.split(~r"Player \d:", trim: true)
      |> Enum.map(&String.split(&1, "\n", trim: true))
      |> Enum.map(&Enum.map(&1, fn x -> String.to_integer(x) end))

    {player1, player2}
  end

  def play({[], p2}), do: p2
  def play({p1, []}), do: p1

  def play({[p1 | p1_tail], [p2 | p2_tail]}) do
    if p1 > p2 do
      play({p1_tail ++ [p1, p2], p2_tail})
    else
      play({p1_tail, p2_tail ++ [p2, p1]})
    end
  end

  def score(list) do
    list
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {v, i} -> v * (i + 1) end)
    |> Enum.sum()
  end

  def part1(file \\ "./inputs/day22.txt") do
    File.read!(file)
    |> parse()
    |> play()
    |> score()
  end

  def recursive_combat(decks), do: decks |> recursive_combat(MapSet.new(), MapSet.new())
  def recursive_combat({[], p2}, _, _), do: {:p2, p2}
  def recursive_combat({p1, []}, _, _), do: {:p1, p1}

  # not sure how I can make the complexity less
  # credo:disable-for-next-line
  def recursive_combat({[p1_head | p1_tail] = p1, [p2_head | p2_tail] = p2}, h1, h2) do
    win = fn
      :p1 -> recursive_combat({p1_tail ++ [p1_head, p2_head], p2_tail}, MapSet.put(h1, p1), MapSet.put(h2, p2))
      :p2 -> recursive_combat({p1_tail, p2_tail ++ [p2_head, p1_head]}, MapSet.put(h1, p1), MapSet.put(h2, p2))
    end

    cond do
      MapSet.member?(h1, p1) || MapSet.member?(h2, p2) ->
        {:p1, p1}

      p1_head <= length(p1_tail) && p2_head <= length(p2_tail) ->
        {w, _} = recursive_combat({Enum.take(p1_tail, p1_head), Enum.take(p2_tail, p2_head)})
        win.(w)

      p1_head > p2_head ->
        win.(:p1)

      p1_head <= p2_head ->
        win.(:p2)
    end
  end

  def part2(file \\ "./inputs/day22.txt") do
    File.read!(file)
    |> parse()
    |> recursive_combat()
    |> elem(1)
    |> score()
  end
end
