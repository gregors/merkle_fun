defmodule MerkleFunTest do
  use ExUnit.Case
  doctest MerkleFun

  @addresses [
    "e85b7e01c94090358Fb294F11f846B6d990516BE",
    "bcD34a4908eAfD3e16b08809FA9557357bF12F09"
  ]

  @three_addresses ["70c3d48FfBb85b5Cb51B0Ae835B5e019e3B71d47" | @addresses]
  @five_addresses [
    "0B206F63e2386c20C25b6901928DB3134Dc6ec51"
    | ["bf4De19Bd8Bf01e1503d4E8d7a3Ab75451dd653d" | @three_addresses]
  ]
  @seven_addresses [
    "8a4f26aa310cfaa0bfb679572bac264e10b83b7b",
    "bd1db599387cefe8cb1bb930f2893397d0c7360e",
    "437306814bd44e00c3050848a630acf00c73705d",
    "aa2e8370515ff6f6d9bb2193e78a0f029f69e648",
    "7e5866042a595197545b8855cbe54d12b6b00e98",
    "6ae07f738c81b580ff537ffe266f4fc298e3272c",
    "44958629e8a217569a474f382512949cfb386146"
  ]

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

  test ".new - with 7 leaves" do
    expected = [
      "303ceaf1723e734239e6277389e335dceb491d970f0939df5442f3e1b3d2e925",
      "765fef4f7022a8741f699b8601560d7bb1fcd3fd18ef356bf0558a34c618723b",
      "32dc8ca919f2d035e7f16dcde4a27643ec570605d81dc0fe025f55eeb1591dcf",
      "6ea40cfb86421f8e6264f14be34afa63efd4b6bd03d17687d803fa604bc8c4d5",
      "dd46f9887cc3e2bf747ba7c44088af72afb7e7ef8a9979aa46bd2d8bba27eccc",
      "b19babd29e7815b696f28283e6ac98b9ac6f765ac5e2c3d7242fcdb9bb52a3e4",
      "fb800734b01c1c5c1d15e4b79bf150c335fb7f93554e92ebb452a09440a6f5e5",
      "0e812e91ffbecace4dd96070cf2a3ae3ccfa4cabcd5b5521a6631b64feeeb5e7",
      "114dfe5ced5f046afff8bd1e24f55b3423eff53de2ef131e3c2218266edf2a55",
      "52a78285a25d74e30043be50c247c58c402e121312ed596deabafba40c2dc667",
      "6772a13d0dc3e75fdc0e39d1f6810ce673fc00495c0544aa8e39f09a35ab4770",
      "b1602e2aab98d8de4e719cd1f574bde135dae520a74b2d41d441ccef5e3f037e",
      "e661403df734ea32520cf963848afaf7fd07cd92765eb51a3d611f4bdc4a8073",
      "fb800734b01c1c5c1d15e4b79bf150c335fb7f93554e92ebb452a09440a6f5e5"
    ]

    mt = MerkleFun.new(@seven_addresses)
    assert MerkleFun.print(mt) === expected
  end

  test ".proof - with 3 leaves" do
    a_expected = ["0xbafc1ea468d5bc155816f3d1bf6b3494328bf5f016ad4203bcad83ef3a558f59"]

    b_expected = [
      "0x486ff72ab227b5f0045d8ab464278dab0b184b24701edce8dd77ff506bfeac71",
      "0xf843099e9ca3770bb7fec2b13d9c2aa355edff986ff294eeb9eee0fc24a1f6a3"
    ]

    c_expected = [
      "0xd8ad60fcef514b5fb0f2001e8a3b3912de1b4876dd659d75174136ad31b9dae5",
      "0xf843099e9ca3770bb7fec2b13d9c2aa355edff986ff294eeb9eee0fc24a1f6a3"
    ]

    [a, b, c] = @three_addresses
    mt = MerkleFun.new(@three_addresses)

    assert MerkleFun.proof(mt, a) === a_expected
    assert MerkleFun.proof(mt, b) === b_expected
    assert MerkleFun.proof(mt, c) === c_expected
  end

  test ".proof - with 7 leaves" do
    a_expected = [
      "0x0e812e91ffbecace4dd96070cf2a3ae3ccfa4cabcd5b5521a6631b64feeeb5e7",
      "0xdd46f9887cc3e2bf747ba7c44088af72afb7e7ef8a9979aa46bd2d8bba27eccc",
      "0x32dc8ca919f2d035e7f16dcde4a27643ec570605d81dc0fe025f55eeb1591dcf"
    ]

    b_expected = [
      "0xb19babd29e7815b696f28283e6ac98b9ac6f765ac5e2c3d7242fcdb9bb52a3e4",
      "0x765fef4f7022a8741f699b8601560d7bb1fcd3fd18ef356bf0558a34c618723b"
    ]

    c_expected = [
      "0x6772a13d0dc3e75fdc0e39d1f6810ce673fc00495c0544aa8e39f09a35ab4770",
      "0x6ea40cfb86421f8e6264f14be34afa63efd4b6bd03d17687d803fa604bc8c4d5",
      "0x32dc8ca919f2d035e7f16dcde4a27643ec570605d81dc0fe025f55eeb1591dcf"
    ]

    d_expected = [
      "0xe661403df734ea32520cf963848afaf7fd07cd92765eb51a3d611f4bdc4a8073",
      "0xfb800734b01c1c5c1d15e4b79bf150c335fb7f93554e92ebb452a09440a6f5e5",
      "0x765fef4f7022a8741f699b8601560d7bb1fcd3fd18ef356bf0558a34c618723b"
    ]

    e_expected = [
      "0xb1602e2aab98d8de4e719cd1f574bde135dae520a74b2d41d441ccef5e3f037e",
      "0xfb800734b01c1c5c1d15e4b79bf150c335fb7f93554e92ebb452a09440a6f5e5",
      "0x765fef4f7022a8741f699b8601560d7bb1fcd3fd18ef356bf0558a34c618723b"
    ]

    f_expected = [
      "0x114dfe5ced5f046afff8bd1e24f55b3423eff53de2ef131e3c2218266edf2a55",
      "0xdd46f9887cc3e2bf747ba7c44088af72afb7e7ef8a9979aa46bd2d8bba27eccc",
      "0x32dc8ca919f2d035e7f16dcde4a27643ec570605d81dc0fe025f55eeb1591dcf"
    ]

    g_expected = [
      "0x52a78285a25d74e30043be50c247c58c402e121312ed596deabafba40c2dc667",
      "0x6ea40cfb86421f8e6264f14be34afa63efd4b6bd03d17687d803fa604bc8c4d5",
      "0x32dc8ca919f2d035e7f16dcde4a27643ec570605d81dc0fe025f55eeb1591dcf"
    ]

    [a, b, c, d, e, f, g] = @seven_addresses
    mt = MerkleFun.new(@seven_addresses)

    assert MerkleFun.proof(mt, a) === a_expected
    assert MerkleFun.proof(mt, b) === b_expected
    assert MerkleFun.proof(mt, c) === c_expected
    assert MerkleFun.proof(mt, d) === d_expected
    assert MerkleFun.proof(mt, e) === e_expected
    assert MerkleFun.proof(mt, f) === f_expected
    assert MerkleFun.proof(mt, g) === g_expected
  end

  test "big test" do
    expected = [
      "0x11481edda7910f8b360477264c7d95efdbbd6c54865b037826116f1381be931c",
      "0xff95de80beb93f114e513fde55bb56aaf97235b88538e44868386fde8ccdd332",
      "0x8b408b46a623e32f2d96cfddf9dbe99ece434616176c88fcaf83b95400990c9c",
      "0x153a7b112244f82b2b7bb1da7aef9575daf7cd6d627348ef5f3fa61b7190623f",
      "0x280988f017470994b78a7d4e7ca9c9a576c87617b08718b431d6b0e31334fa5d",
      "0x6a886c782ce372011493b26dad44792edce43a55419b712e303e7829257c2610",
      "0xf57cdf09c8dd33cfa2fd1f5a295e05896a05de60c763071bcff683b26de01947",
      "0x52a88fff99be8327601afcd937c28ea226d31b80cc428679fad2a05200648622",
      "0x5609be6fcc1286912b191ef479e94817df95221f734f3d779eaf9d1b922cf017",
      "0xd266d1f339829e566da76e6d8cf46c72d17a7c3ad876dd885fd88031e6b76038",
      "0xc37fc574462a5112a0e0792f52a7e84e888662f94fba6fe895a7c93fb0c63b34",
      "0x72b7cebabda59238c211cd17dec39c97e2f482d88f6ec1c3fb3bdc3ab03bd208"
    ]

    {:ok, data} = File.read("./test/test_addresses.txt")

    proof =
      data
      |> String.split()
      |> Enum.map(fn "0x" <> address -> address end)
      |> MerkleFun.new()
      # |> :erlang.term_to_binary() |> :erlang.byte_size() |> IO.inspect
      |> MerkleFun.proof("8a4f26aa310cfaa0bfb679572bac264e10b83b7b")

    assert proof == expected
  end
end
