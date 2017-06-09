defmodule Tccv2.Repo.Migrations.AddCategoriaIdToRestaurante do
  use Ecto.Migration

  def change do
    alter table(:restaurantes) do
      add :categoria_id, references(:categorias)
    end

  end
end
