defmodule MerkleFun do
  require Integer

  def new(input) do
    tree = build_tree(input)

    {tree, tuple_size(tree)}
  end

  def root({tree, _size}), do: elem(tree, 0)

  def proof({tree, _len} = m, leaf) do
    leaf_hash = hash(leaf)

    idx = tree
          |> Tuple.to_list()
          |> Enum.find_index(fn l -> l === leaf_hash end)

    _proof(m, idx)
      |> Enum.map(fn i -> "0x" <> i end)
  end

  defp _proof(_tree, 0), do: []

  defp _proof({tree, len}=m, idx) do
    parent_idx = Integer.floor_div(idx-1, 2)
    sibling_idx = get_sibling_idx(idx, len)
    proof_node = elem(tree, sibling_idx)

    [proof_node | _proof(m, parent_idx)]
  end

  defp get_sibling_idx(0, _), do: 0

  defp get_sibling_idx(idx, len) do
    sibling_idx = if(Integer.is_even(idx)) do
      idx - 1
    else
      idx + 1
    end

    if(sibling_idx > len) do
      idx
    else
      sibling_idx
    end
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

  defp combine(a, b) do
    if(a == b) do
      a
    else
      hash(a <> b)
    end
  end

  defp hash(data) do
    data
    |> String.upcase()
    |> Base.decode16!()
    |> ExKeccak.hash_256()
    |> Base.encode16(case: :lower)
  end
end
