defmodule MerkleFun do
  require Integer

  def new(input, sort_pairs \\ true) do
    leaves =
      input
      |> Enum.map(&hash_leaf/1)
      |> Enum.sort()

    leaves = leaves ++ add_padding_rows(leaves)

    _build_tree(leaves, [], sort_pairs) |> List.to_tuple()
  end

  def root(tree), do: bytes_to_string(elem(tree, 0)) |> add_0x()

  def print(tree) do
    tree
    |> Tuple.to_list()
    |> Enum.reject(fn x -> x == 1 end)
    |> Enum.map(&bytes_to_string/1)
  end

  def proof(tree, leaf) do
    leaf_hash = hash_leaf(leaf)

    idx =
      tree
      |> Tuple.to_list()
      |> Enum.find_index(fn l -> l === leaf_hash end)

    _proof(tree, idx)
    |> Enum.map(&bytes_to_string/1)
    |> Enum.reject(fn x -> x == 1 end)
    |> Enum.map(&add_0x/1)
  end

  def verify(proof, leaf) do
    leaf_hash = hash_leaf(leaf)

    proof
    |> Enum.map(&remove_0x/1)
    |> Enum.map(fn s -> Base.decode16!(s, case: :mixed) end)
    |> Enum.reduce(leaf_hash, fn x, y -> hash(x, y, true) end)
    |> bytes_to_string()
    |> add_0x()
  end

  def verify(proof, node, known_root), do: verify(proof, node) == known_root

  defp _proof(_, 0), do: []

  defp _proof(tree, idx) do
    sibling_idx = sibling_idx(idx)
    node = elem(tree, sibling_idx)

    parent_idx = Integer.floor_div(idx - 1, 2)

    [node | _proof(tree, parent_idx)]
  end

  defp _build_tree([root], acc, _sort_pairs), do: [root | acc]

  defp _build_tree(level, acc, sort_pairs) do
    new_level =
      level
      |> Enum.chunk_every(2)
      |> Enum.map(fn
        [x, 1] -> x
        # needs test
        [1, x] -> x
        [x, y] -> hash(x, y, sort_pairs)
      end)

    _build_tree(new_level, level ++ acc, sort_pairs)
  end

  defp hash(data), do: data |> ExKeccak.hash_256()

  defp hash(x, y, sort) do
    [x, y] =
      if sort do
        [x, y] |> Enum.sort()
      else
        [x, y]
      end

    ExKeccak.hash_256(x <> y)
  end

  defp hash_leaf(leaf) do
    leaf
    |> remove_0x()
    |> Base.decode16!(case: :mixed)
    |> hash()
  end

  defp sibling_idx(idx) do
    if Integer.is_even(idx) do
      idx - 1
    else
      idx + 1
    end
  end

  defp bytes_to_string(1), do: 1

  defp bytes_to_string(bytes) do
    Base.encode16(bytes, case: :lower)
  end

  defp add_0x(s), do: "0x#{s}"
  defp remove_0x("0x" <> s), do: s
  defp remove_0x("0X" <> s), do: s
  defp remove_0x(s), do: s

  defp add_padding_rows(leaves) do
    size = length(leaves)
    num = :math.log2(size) |> ceil
    num = 2 ** num
    padding_num = num - size

    List.duplicate(1, padding_num)
  end
end
