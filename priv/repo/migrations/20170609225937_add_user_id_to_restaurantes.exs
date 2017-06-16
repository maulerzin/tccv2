defmodule Tccv2.Repo.Migrations.AddUserIdToRestaurantes do
  use Ecto.Migration

  def change do
    alter table(:restaurantes) do
      add :user_id, references(:users, on_delete: :delete_all)
    end

  end
end
