defmodule Tccv2.Carrinho do
  use Tccv2.Web, :model

  schema "carrinhos" do
    field :uuid, Ecto.UUID, autogenerate: true
    has_many :line_items, Tccv2.LineItem

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uuid])
  end
end
