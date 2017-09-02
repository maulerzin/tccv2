defmodule Tccv2.Repo.Migrations.CreatePrato do
  use Ecto.Migration

  def change do
    create table(:pratos) do
      add :nome, :string
      add :valor, :decimal

      timestamps()
    end

  end
end
