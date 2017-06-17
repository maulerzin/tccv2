defmodule Tccv2.Prato do
  use Tccv2.Web, :model

  schema "pratos" do
    field :nome, :string
    field :valor, :float

    belongs_to :restaurante, Nested.Restaurante

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :valor, :restaurante_id])
    |> validate_required([:nome, :valor, :restaurante_id])
  end
end
