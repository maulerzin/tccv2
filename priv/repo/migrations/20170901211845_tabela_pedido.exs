defmodule Tccv2.Repo.Migrations.TabelaPedido do
  use Ecto.Migration

  def change do

    create table(:pedidos) do
          timestamps()
        end

        alter table(:line_items) do
          add :pedido_id, references(:pedidos)
        end
  end
end
