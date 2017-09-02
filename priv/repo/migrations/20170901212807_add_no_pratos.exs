defmodule Tccv2.Repo.Migrations.AddNoPratos do
  use Ecto.Migration

  def change do
    alter table(:pratos) do
      add :descricao, :text
      add :imagem, :string

    end
  end
end
