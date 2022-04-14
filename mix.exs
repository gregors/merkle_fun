defmodule MerkleFun.MixProject do
  use Mix.Project

  @repo_url "https://github.com/gregors"

  def project do
    [
      app: :merkle_fun,
      version: "0.3.0",
      description: "Merkle Tree implementation",
      name: "Merkle Fun",
      package: package(),
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      source_url: @repo_url,
      deps: deps()
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Gregory Ostermayr", "Rodger Maarfi"],
      licenses: ["MIT"],
      links: %{"GitHub" => @repo_url}
    ]
  end

  defp deps do
    [
      {:ex_keccak, "~> 0.4.0"},
      {:benchee, "~> 1.0", only: :dev},
      {:ex_doc, ">= 0.19.0", only: :dev}
    ]
  end
end
