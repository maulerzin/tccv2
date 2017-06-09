defmodule Tccv2.Categoria do
  use Tccv2.Web, :model

  schema "categorias" do
    field :nome, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nome])
    |> validate_required([:nome])
  end

  def alphabetical(query) do
    from c in query, order_by: c.nome
  end
  def names_and_ids(query) do
    from c in query, select: {c.nome, c.id}
  end
end
