defmodule Tccv2.Repo.Migrations.AddUser do
  use Ecto.Migration

  def change do alter table(:users) do
    add :estado, :string
    add :cidade, :string
    add :bairro, :string
    add :cep, :string
    add :cpf, :string
    add :endereco, :string
    add :telefone, :string
  end
  end
end
