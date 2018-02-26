# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tccv2.Repo.insert!(%Tccv2.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Tccv2.Repo
alias Tccv2.Categoria

for categoria <- ~w(Japonês Pizza Lanches Saudável Doces ) do
  Repo.get_by(Categoria, nome: categoria) ||
    Repo.insert!(%Categoria{nome: categoria})
end
