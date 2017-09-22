defmodule Tccv2.Repo.Migrations.AddValorNoLineItems do
  use Ecto.Migration

  def change do
    alter table(:line_items) do
      add :valor, :decimal

    end
  end
end
