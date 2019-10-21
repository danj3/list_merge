defmodule ListMerge do
  @moduledoc """
  Perform a database type join operation on a list of lexically sorted lists.

  Using protocol ListMerge.Op to access the desired `key`, iterates through
  the list of lists once and combines elements with equal keys into a
  cell of lists.

  Keys cannot be repeated within each input sublist.
  """

  @compile export: :all

  alias ListMerge.Op

  def merge( lists ) do
    merge_aux( lists, [] )
  end

  defp merge_aux( lists, result ) do
    heads = list_heads( lists )
    if heads == [] do
      result
    else
      new = least_equal( heads )
      next_lists = pop_heads( new, lists )
      merge_aux( next_lists, [ new | result ] )
    end
  end

  defp list_heads( lists ) do
    lists
    |> Enum.map( &List.first/1 )
    |> Enum.filter( fn nil -> false; _ -> true end)
  end

  defp least_equal( [ h1 | rest ] ) do
    Enum.reduce( rest, [ h1 ],
      fn hx, [ h2 | _ ] = acc ->
        cond do
          Op.a_less_than_b( hx, h2 ) -> [ hx ]
          Op.equal( hx, h2 ) -> [ hx | acc ]
          true -> acc
        end
      end)
  end

  defp pop_heads( ref, lists ) do
    keys = Enum.map( ref, &Op.key/1 )

    lists
    |> Enum.map( fn
      [ h | t ] = a ->
      if Enum.find( keys, fn mk -> Op.equal_to_key( h, mk ) end), do: t, else: a
      [] -> []
    end)
  end
end
