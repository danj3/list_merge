# ListMerge

Merge a list of lexically sorted lists, using a protocol for returning
an element key, with a each resulting cell containing a list of
key-equal elements from the original lists.

In effect, this is a database type join operation on a list of lists.

## Example (from test)

```
input = [
  [ 1,3,5,6,8 ],
  [ 5,8 ],
  [ 1,3,8 ]
]

ListMerge.merge( input )

Results in:

[
  [8, 8, 8],
  [6],
  [5,5],
  [3,3],
  [1,1]
]
```

The result is reversed from the input. Use Enum.reverse to return the ordering.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `list_merge` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:list_merge, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/list_merge](https://hexdocs.pm/list_merge).

