defmodule Tccv2.Repo.Migrations.CreateCategoria do
  use Ecto.Migration

  def change do
    create table(:categorias) do
      add :nome, :string, null: false

      timestamps()
    end

    create unique_index(:categorias, [:nome])
  end
end
