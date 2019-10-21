defprotocol ListMerge.Op do
  @doc "Return key for data"
  def key( data )

  @doc "Return true if key of a is less than key of b"
  def a_less_than_b( a, b )

  @doc "Return true if key of a is equal to key of b"
  def equal( a, b )

  @doc """
  Return true if key of `a` is equal to `key`.
  The value of `key` would be provided by a caller through
  the use of the `key()` function of this protocol.
  """
  def equal_to_key( a, key )
end

defimpl ListMerge.Op, for: [ BitString, Integer ] do
  def key( data ), do: data
  def a_less_than_b( a, b ), do: a < b
  def equal( a, b ), do: a == b
  def equal_to_key( a, key ), do: a == key
end
