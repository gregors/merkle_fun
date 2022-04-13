defmodule MerkleFun do
  require Integer

  def new(input) do
    tree = build_tree(input)

    {tree, tuple_size(tree)}
  end

  def root({tree, _size}), do: bytes_to_string(elem(tree, 0))

  def print({tree, _size}) do
    tree
    |> Tuple.to_list()
    |> Enum.reject(fn x -> x == 1 end)
    |> Enum.map(&bytes_to_string/1)
  end

  def proof({tree, _} = mt, leaf) do
    leaf_hash =
      leaf
      |> Base.decode16!(case: :mixed)
      |> hash()

    idx =
      tree
      |> Tuple.to_list()
      |> Enum.find_index(fn l -> l === leaf_hash end)

    _proof(mt, idx)
    |> Enum.map(&bytes_to_string/1)
    |> Enum.map(&add_0x/1)
  end

  defp _proof(_tree, 0), do: []

  defp _proof({tree, _len} = mt, idx) do
    sibling_idx = get_sibling_idx(idx)
    proof_node = elem(tree, sibling_idx)

    parent_idx = Integer.floor_div(idx - 1, 2)

    [proof_node | _proof(mt, parent_idx)]
  end

  defp build_tree(data) do
    leaves =
      data
      |> Enum.map(fn x -> Base.decode16!(x, case: :mixed) end)
      |> Enum.map(&hash/1)
      |> Enum.sort()

    tree = _build_tree(leaves, [])

    {_, padded_tree} =
      Enum.reduce(tree, {1, []}, fn row, {num, rows} ->
        padded_row = pad_row(num, row)
        {num * 2, [padded_row | rows]}
      end)

    padded_tree
    |> Enum.reverse()
    |> List.flatten()
    |> List.to_tuple()
  end

  defp pad_row(num, row) do
    true_len = length(row)

    if num == 1 || true_len == num do
      row
    else
      add_amount = num - true_len
      # pad using 1, takes less space than nil
      padding = List.duplicate(1, add_amount)
      row ++ padding
    end
  end

  defp _build_tree([root], acc), do: [[root] | acc]

  defp _build_tree(level, acc) do
    new_level =
      level
      |> Enum.chunk_every(2)
      |> Enum.map(fn
        [x] -> x
        [x, y] -> combine(x, y)
      end)

    _build_tree(new_level, [level | acc])
  end

  defp combine(a, b) do
    if(a == b) do
      a
    else
      hash(a <> b)
    end
  end

  defp hash(data), do: data |> ExKeccak.hash_256()

  defp get_sibling_idx(0), do: 0

  defp get_sibling_idx(idx) do
    if Integer.is_even(idx) do
      idx - 1
    else
      idx + 1
    end
  end

  defp bytes_to_string(bytes), do: Base.encode16(bytes, case: :lower)

  defp add_0x(s), do: "0x#{s}"
end
