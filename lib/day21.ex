defmodule Day21 do
  def parse_line(line) do
    [ingredients | [allergens]] = String.split(line, ["(", ")"], trim: true)

    ingredient_list = String.split(ingredients, " ", trim: true) |> MapSet.new()

    allergen_set =
      allergens
      |> String.trim_leading("contains ")
      |> String.split(", ", trim: true)

    {ingredient_list, allergen_set}
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def reduce_ingredients(list), do: reduce_ingredients(list, %{}, %{})
  def reduce_ingredients([], acc, occ), do: {acc, occ}

  def reduce_ingredients([{ingredient_list, allergen_list} | tail], acc, occ) do
    occ = Enum.reduce(ingredient_list, occ, &Map.update(&2, &1, 1, fn x -> x + 1 end))

    acc =
      Enum.reduce(allergen_list, acc, fn allergen, acc ->
        Map.update(
          acc,
          allergen,
          ingredient_list,
          &MapSet.intersection(&1, ingredient_list)
        )
      end)

    reduce_ingredients(tail, acc, occ)
  end

  def part1 do
    input = File.read!("./inputs/day21.txt") |> parse()
    {map, count} = reduce_ingredients(input)

    Enum.reject(count, fn {name, _} ->
      Enum.any?(map, &(name in elem(&1, 1)))
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def remove_ingredient(map, ingredient) do
    Enum.map(map, fn {allergen, set} ->
      {allergen, MapSet.delete(set, ingredient)}
    end)
  end

  def sort_allergens(map), do: Enum.sort_by(map, &elem(&1, 1))

  def reduce_allergens(list), do: reduce_allergens(list, [])
  def reduce_allergens([], acc), do: acc

  def reduce_allergens([{allergen, ingredient_set} | tail], acc) do
    ingredient = Enum.at(ingredient_set, 0)

    tail
    |> remove_ingredient(ingredient)
    |> sort_allergens()
    |> reduce_allergens([{allergen, ingredient} | acc])
  end

  def part2(file \\ "./inputs/day21.txt") do
    file
    |> File.read!()
    |> parse
    |> reduce_ingredients
    |> elem(0)
    |> Map.to_list()
    |> sort_allergens
    |> reduce_allergens
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
    |> Enum.join(",")
  end
end
