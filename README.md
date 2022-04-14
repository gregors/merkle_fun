# MerkleFun

[Merkle tree](https://en.wikipedia.org/wiki/Merkle_tree) implementation using the excellent and fast rust-powered ex_keccak library under the hood.
If you'd like to know more about the basic algorithm, check out this great [introductory talk](https://youtu.be/HdGpG0kcEGU?t=132).

## Installation

The package can be installed
by adding `merkle_fun` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:merkle_fun, "~> 0.3.0"}
  ]
end
```

## Design

### binary tree

There are multiple ways to implement a binary tree. We decided to use an [array format](https://opendsa-server.cs.vt.edu/ODSA/Books/Everything/html/CompleteTree.html) approach to minimize storage requirements and make the sibling lookup easy. If it's been a while since you've done a basic data structures could check out this [refresher](https://www.youtube.com/watch?v=zDlTxrEwxvg).

Wait a minute you say! Elixir doesn't have arrays? Well there is an [Erlang implementation](https://www.erlang.org/doc/man/array.html) as well as a nice [Elixir library](https://github.com/Qqwy/elixir-arrays). However, after thinking about the problem our use case didn't need updates. We build the tree and don't need to append further nodes. In such a case a tuple suits our [read only needs](https://stackoverflow.com/questions/16447921/arrays-implementation-in-erlang/16464349#16464349) perfectly. If we decide to add Merkle Mountain Ranges (in the future) we will need something with better append performance.

### leaf lookup

Initial leaf lookup is currently looking through the entire tree. Yeah I need to fix that.

## Warning

* second pre-image attack
* unbalanced trees attack

## Todo's
* [x] Make tree
* [x] Make proof
* [ ] Validate proof
* [ ] Pretty Print tree
* [ ] Fast leaf look up



## Thanks

Thanks goes out to Rodger Maarfi (@acrite22) for pairing with me on this.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/merkle_fun>.

