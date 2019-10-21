defmodule ListMergeTest do
  use ExUnit.Case
  doctest ListMerge

  setup_all do
    [ numbers: [
        [ 1,3,5,6,8 ],
        [ 5,8 ],
        [ 1,3,8 ]
      ],
      string: [
        ~w( apple banana grape zebra ),
        ~w( gorilla zebra ),
        ~w( orangutan ),
        ~w( banana grape ),
        ~w( apple orangutan )
      ]
    ]
  end

  test "numbers", %{ numbers: lists } do
    assert [
      [8, 8, 8],
      [6],
      [5,5],
      [3,3],
      [1,1]
      ] == ListMerge.merge( lists )
  end

  test "strings", %{ string: lists } do
    assert [
      ["zebra", "zebra"],
      ["orangutan", "orangutan"],
      ["grape", "grape"],
      ["gorilla"],
      ["banana", "banana"],
      ["apple", "apple"]
    ] == ListMerge.merge( lists )
  end

  test "singles" do
    lists = [
      ~w( apple ),
      ~w( banana ),
      ~w( bird ),
      ~w( crow raven )
    ]
    assert [
      ["raven"],
      ["crow"],
      ["bird"],
      ["banana"],
      ["apple"]
    ] == ListMerge.merge( lists )
  end

  test "singles and a double" do
    lists = [
      ~w( apple ),
      ~w( banana ),
      ~w( bird ),
      ~w( crow raven ),
      ~w( bird ),
    ]
    assert [
      ["raven"], ["crow"], ["bird", "bird"], ["banana"], ["apple"]
    ] == ListMerge.merge( lists )
  end

  describe "Result of invalid inputs" do

    test "err1" do
      lists = [
        ~w( apple apple ),
        ~w( banana ),
      ]
      assert [["banana"], ["apple"], ["apple"]] == ListMerge.merge( lists )
    end

    test "err2" do
      lists = [
        ~w( banana apple ),
        ~w( banana ),
        ~w( apple )
      ]
      assert [
        ["apple"], ["banana", "banana"], ["apple"]
      ] == ListMerge.merge( lists )
    end
  end

end
