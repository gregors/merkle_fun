defmodule MerkleFunTest do
  use ExUnit.Case
  doctest MerkleFun

  @addresses [
    "e85b7e01c94090358Fb294F11f846B6d990516BE",
    "bcD34a4908eAfD3e16b08809FA9557357bF12F09"
  ]

  test ".new - makes a tree" do
    expected = [
      "486ff72ab227b5f0045d8ab464278dab0b184b24701edce8dd77ff506bfeac71",
      "d8ad60fcef514b5fb0f2001e8a3b3912de1b4876dd659d75174136ad31b9dae5"
    ]

    assert MerkleFun.new(@addresses) === expected
  end

  test ".test" do
    hashes = [
      "486ff72ab227b5f0045d8ab464278dab0b184b24701edce8dd77ff506bfeac71",
      "d8ad60fcef514b5fb0f2001e8a3b3912de1b4876dd659d75174136ad31b9dae5"
    ]
    expected = "bafc1ea468d5bc155816f3d1bf6b3494328bf5f016ad4203bcad83ef3a558f59"

    assert MerkleFun.test(hashes) === expected
  end
end
