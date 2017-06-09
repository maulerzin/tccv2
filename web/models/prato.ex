defmodule Tccv2.Prato do
  use Tccv2.Web, :model

  schema "pratos" do
    field :nome, :string
    field :valor, :float

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :valor])
    |> validate_required([:nome, :valor])
  end
end
