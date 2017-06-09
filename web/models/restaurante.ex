defmodule Tccv2.Restaurante do
  use Tccv2.Web, :model

  schema "restaurantes" do
    field :nome, :string
    field :cnpj, :string
    field :logo, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :cnpj, :logo])
    |> validate_required([:nome, :cnpj, :logo])
  end
end
