defmodule MerkleFun do
  require Integer

  def new(input) do
    build_tree(input)
  end

  def root(tree), do: bytes_to_string(elem(tree, 0))

  def print(tree) do
    tree
    |> Tuple.to_list()
    |> Enum.reject(fn x -> x == 1 end)
    |> Enum.map(&bytes_to_string/1)
  end

  def proof(tree, leaf) do
    leaf_hash =
      leaf
      |> Base.decode16!(case: :mixed)
      |> hash()

    idx =
      tree
      |> Tuple.to_list()
      |> Enum.find_index(fn l -> l === leaf_hash end)

    _proof(tree, idx)
    |> Enum.map(&bytes_to_string/1)
    |> Enum.map(&add_0x/1)
  end

  defp _proof(_, 0), do: []

  defp _proof(tree, idx) do
    sibling_idx = get_sibling_idx(idx)
    node = elem(tree, sibling_idx)

    parent_idx = Integer.floor_div(idx - 1, 2)

    [node | _proof(tree, parent_idx)]
  end

  defp build_tree(data) do
    leaves =
      data
      |> Enum.map(fn x -> Base.decode16!(x, case: :mixed) |> hash() end)
      |> Enum.sort()

    leaves = leaves ++ add_padding_rows(leaves)

    _build_tree(leaves, [])
    |> List.to_tuple()
  end

  defp _build_tree([root], acc), do: [root | acc]

  defp _build_tree(level, acc) do
    new_level =
      level
      |> Enum.chunk_every(2)
      |> Enum.map(fn
        [x, 1] -> x
        [x, y] -> hash(x <> y)
      end)

    _build_tree(new_level, level ++ acc)
  end

  defp hash(data), do: data |> ExKeccak.hash_256()

  defp get_sibling_idx(idx) do
    if Integer.is_even(idx) do
      idx - 1
    else
      idx + 1
    end
  end

  defp bytes_to_string(bytes), do: Base.encode16(bytes, case: :lower)

  defp add_0x(s), do: "0x#{s}"

  defp add_padding_rows(leaves) do
    size = length(leaves)
    num = :math.log2(size) |> ceil
    num = 2 ** num
    num = num - size
    # pad with 1, uses less space
    List.duplicate(1, num)
  end
end
