defmodule MerkleFun do
  def new(input) do
    build_tree(input)
  end

  def combine(a, b), do: hash(a <> b)

  def build_tree(data) do
    leaves = data
           |> Enum.sort
           |> Enum.map(fn x ->  hash(x) end)

    _build_tree(leaves, nil)
  end

  def _build_tree([], root), do: root
  def _build_tree([a, b | rest], root) do
    new_hash = combine(a, b)

    _build_tree(rest, root)
  end

  def hash(data) do
    data
    |> String.upcase()
    |> Base.decode16!()
    |> ExKeccak.hash_256()
    |> Base.encode16(case: :lower)
  end
end
