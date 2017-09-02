defmodule Tccv2.Repo.Migrations.TabelaCart do
  use Ecto.Migration

  def change do


    create table(:carrinhos) do
        add :uuid, :uuid

        timestamps()
      end  
  end
end
