defmodule Tccv2.Repo.Migrations.TabelaLineItem do
  use Ecto.Migration

  def change do
    create table(:line_items) do
          add :quantity, :integer
          add :prato_id, references(:pratos, on_delete: :nothing)
          add :carrinho_id, references(:carrinhos)

          timestamps()
        end
        create index(:line_items, [:prato_id])
  end
end
