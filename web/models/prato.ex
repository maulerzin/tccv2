defmodule Tccv2.Prato do
  use Tccv2.Web, :model

  schema "pratos" do
    field :nome, :string
    field :valor, :decimal
    field :descricao, :string
    field :imagem, :string

    belongs_to :restaurante, Nested.Restaurante

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :descricao, :valor, :restaurante_id])
    #|> cast_attachments(params, [:imagem])
    |> validate_required([:nome, :descricao, :valor, :restaurante_id])
  end
end
