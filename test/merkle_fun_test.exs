defmodule MerkleFunTest do
  use ExUnit.Case
  doctest MerkleFun

  @addresses [
    "e85b7e01c94090358Fb294F11f846B6d990516BE",
    "bcD34a4908eAfD3e16b08809FA9557357bF12F09"
  ]

  @three_addresses [ "70c3d48FfBb85b5Cb51B0Ae835B5e019e3B71d47" | @addresses ]
  @five_addresses [ "0B206F63e2386c20C25b6901928DB3134Dc6ec51" | ["bf4De19Bd8Bf01e1503d4E8d7a3Ab75451dd653d" | @three_addresses ]]


  test ".new - with even leaves" do
    expected = [
      "bafc1ea468d5bc155816f3d1bf6b3494328bf5f016ad4203bcad83ef3a558f59",
      "486ff72ab227b5f0045d8ab464278dab0b184b24701edce8dd77ff506bfeac71",
      "d8ad60fcef514b5fb0f2001e8a3b3912de1b4876dd659d75174136ad31b9dae5"
    ]

    mt = MerkleFun.new(@addresses)
    assert MerkleFun.print(mt) === expected
  end

  test ".new - with 3 leaves" do
    expected = [
      "d8458a9d64fe8b0d8ede527319e148b5edd58a8a106146e3007db26e43395c8c",
         "bafc1ea468d5bc155816f3d1bf6b3494328bf5f016ad4203bcad83ef3a558f59",
         "f843099e9ca3770bb7fec2b13d9c2aa355edff986ff294eeb9eee0fc24a1f6a3",
            "486ff72ab227b5f0045d8ab464278dab0b184b24701edce8dd77ff506bfeac71",
            "d8ad60fcef514b5fb0f2001e8a3b3912de1b4876dd659d75174136ad31b9dae5",
            "f843099e9ca3770bb7fec2b13d9c2aa355edff986ff294eeb9eee0fc24a1f6a3"
      ]

    mt = MerkleFun.new(@three_addresses)
    assert MerkleFun.print(mt) === expected
  end

  test ".new - with 5 leaves" do
    expected = [
      "baebf911b5f02042fdc10703d38c6819c7767aac44555dc63cf6ddb3a1b8c96b",
      "8b98e4697a160a7c91f637a11e9833e640a2595d83a3921ff1f53f21263c352c",
      "f843099e9ca3770bb7fec2b13d9c2aa355edff986ff294eeb9eee0fc24a1f6a3",
      "767de5c8d4c4e33f229b2c8fbac72e2a1e9fb88972daf92f23ac949c39782d00",
      "f83ae18cad0a26cc72618add6f91dffdc4d218e73ae2d84441eabaaca9f800b0",
      "f843099e9ca3770bb7fec2b13d9c2aa355edff986ff294eeb9eee0fc24a1f6a3",
      "486ff72ab227b5f0045d8ab464278dab0b184b24701edce8dd77ff506bfeac71",
      "7358bb86b9c1f200ad6a9ed9e9e6a1726f344df920f3c2e69ce7e30ac810eead",
      "816e3ac40ef366b37344757d01aae811a2e218621721e0ee0a11a4744abc960d",
      "d8ad60fcef514b5fb0f2001e8a3b3912de1b4876dd659d75174136ad31b9dae5",
      "f843099e9ca3770bb7fec2b13d9c2aa355edff986ff294eeb9eee0fc24a1f6a3"
    ]

    mt = MerkleFun.new(@five_addresses)
    assert MerkleFun.print(mt) === expected
  end

  test ".proof - with 3 leaves" do
    expected = [
      "0x486ff72ab227b5f0045d8ab464278dab0b184b24701edce8dd77ff506bfeac71",
      "0xf843099e9ca3770bb7fec2b13d9c2aa355edff986ff294eeb9eee0fc24a1f6a3"
    ]

    mt = MerkleFun.new(@three_addresses)

    assert MerkleFun.proof(mt, "e85b7e01c94090358Fb294F11f846B6d990516BE") === expected
  end
end
