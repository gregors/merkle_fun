defmodule MerkleFun do
  require Integer

  def new(input) do
    build_tree(input)
  end

  def root(tree) do
    elem(tree, 0)
  end

  def proof(tree, leaf) do
    leaf_hash = hash(leaf)

    list_tree = Tuple.to_list(tree)
    idx = Enum.find_index(list_tree, fn l -> l === leaf_hash end)

    _proof(tree, idx)
      |> Enum.map(fn i -> "0x" <> i end)
  end

  defp _proof(_tree, 0) do
    []
  end

  defp _proof(tree, idx) do
    parent_idx = Integer.floor_div(idx-1, 2)
    sibling_idx = get_sibling_idx(tree, idx)
    proof_node = elem(tree, sibling_idx)

    [proof_node | _proof(tree, parent_idx)]
  end

  defp get_sibling_idx(_tree, 0), do: 0

  defp get_sibling_idx(tree, idx) do
    list_tree = Tuple.to_list(tree)
    len = length(list_tree)

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

  # defp _verify(tree, idx) do
  #   IO.inspect "proof +1"
  #   node = elem(tree, idx)
  #   sibling = get_sibling(tree, idx)
  #   parent = if(Integer.is_even(idx)) do
  #     combine(sibling, node)
  #   else
  #     combine(node, sibling)
  #   end

  #   parent_idx = Integer.floor_div(idx-1, 2)
  #   [parent | _proof(tree, parent_idx)]
  # end

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
