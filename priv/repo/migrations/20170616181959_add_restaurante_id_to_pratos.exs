defmodule Tccv2.Repo.Migrations.AddRestauranteIdToPratos do
  use Ecto.Migration

  def change do
    alter table(:pratos) do
      add :restaurante_id, references(:restaurantes, on_delete: :delete_all)
    end
  end
end
