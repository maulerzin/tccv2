defmodule Tccv2.LineItem do
  use Tccv2.Web, :model

  schema "line_items" do
    field :quantity, :integer
    belongs_to :prato, Tccv2.Prato
    belongs_to :carrinho, Tccv2.Carrinho
    belongs_to :pedido, Tccv2.Pedido

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:quantity, :prato_id, :carrinho_id])
    |> validate_required([:quantity, :prato_id])
  end
end
