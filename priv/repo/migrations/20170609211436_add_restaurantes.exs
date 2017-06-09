defmodule Tccv2.Repo.Migrations.AddRestaurantes do
  use Ecto.Migration

  def change do
    alter table(:restaurantes) do
      add :endereco, :string
      add :estado, :string
      add :cidade, :string
      add :bairro, :string
      add :telefone, :string
      add :cep, :string

      
end
  end
end
