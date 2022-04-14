{:ok, data} = File.read("./test/test_addresses.txt")

rows =
  data
  |> String.split()
  |> Enum.map(fn "0x" <> address -> address end)

new_rows =  List.duplicate(1, 1000)

Benchee.run(%{
  "build"  => fn -> MerkleFun.new(rows) end,
})
