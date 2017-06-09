defmodule Tccv2.Repo.Migrations.CreateRestaurante do
  use Ecto.Migration

  def change do
    create table(:restaurantes) do
      add :nome, :string
      add :cnpj, :string
      add :logo, :string

      timestamps()
    end

  end
end
