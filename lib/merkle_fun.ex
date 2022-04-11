defmodule MerkleFun do
  def new(input) do
    build_tree(input)
  end

  def root(tree) do
    elem(tree, 0)
  end

  defp build_tree(data) do
    leaves = data
           |> Enum.map(&hash/1)
           |> Enum.sort

    _build_tree(leaves, [])
    |> List.to_tuple
  end

  defp _build_tree([root], acc), do: [root | acc]
  defp _build_tree(level, acc) do
    new_level = level
    |> Enum.chunk_every(2)
    |> Enum.map(fn
      [x] -> x
      [x, y] -> combine(x, y)
    end)

    _build_tree(new_level, level ++ acc)
  end

  defp combine(a, b), do: hash(a <> b)

  defp hash(data) do
    data
    |> String.upcase()
    |> Base.decode16!()
    |> ExKeccak.hash_256()
    |> Base.encode16(case: :lower)
  end
end
