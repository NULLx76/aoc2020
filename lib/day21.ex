defmodule Day21 do
  def parse_line(line) do
    [ingredients | [allergens]] = String.split(line, ["(", ")"], trim: true)

    ingredient_set = String.split(ingredients, " ", trim: true) |> MapSet.new()

    allergen_list =
      allergens
      |> String.trim_leading("contains ")
      |> String.split(", ", trim: true)

    {ingredient_set, allergen_list}
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def identify_ingredients(list), do: identify_ingredients(list, %{}, %{})
  def identify_ingredients([], acc, occ), do: {acc, occ}

  def identify_ingredients([{ingredient_set, allergen_list} | tail], acc, occ) do
    occ = Enum.reduce(ingredient_set, occ, &Map.update(&2, &1, 1, fn x -> x + 1 end))

    acc =
      Enum.reduce(allergen_list, acc, fn allergen, acc ->
        Map.update(acc, allergen, ingredient_set, &MapSet.intersection(&1, ingredient_set))
      end)

    identify_ingredients(tail, acc, occ)
  end

  def sort_allergens(map), do: Enum.sort_by(map, &elem(&1, 1))

  def identify_allergens(map) do
    map
    |> Enum.to_list()
    |> sort_allergens()
    |> identify_allergens([])
  end

  def identify_allergens([], acc), do: acc

  def identify_allergens([{allergen, ingredient_set} | tail], acc) do
    ingredient = Enum.at(ingredient_set, 0)

    tail
    |> Enum.map(fn {k, v} -> {k, MapSet.delete(v, ingredient)} end)
    |> sort_allergens()
    |> identify_allergens([{allergen, ingredient} | acc])
  end

  def part1 do
    input = File.read!("./inputs/day21.txt") |> parse()
    {map, count} = identify_ingredients(input)

    Enum.reject(count, fn {name, _} ->
      Enum.any?(map, &(name in elem(&1, 1)))
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def part2(file \\ "./inputs/day21.txt") do
    file
    |> File.read!()
    |> parse
    |> identify_ingredients
    |> elem(0)
    |> identify_allergens
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
    |> Enum.join(",")
  end
end
