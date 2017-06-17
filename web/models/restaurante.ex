defmodule Tccv2.Restaurante do
  use Tccv2.Web, :model

  schema "restaurantes" do
    field :nome, :string
    field :cnpj, :string
    field :endereco, :string
    field :estado, :string
    field :cidade, :string
    field :bairro, :string
    field :telefone, :string
    field :cep, :string

    field :logo, :string

    belongs_to :categoria, Tccv2.Categoria
    belongs_to :user, Tccv2.User
    has_many :pratos, Tccv2.Prato


    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :cnpj, :endereco, :estado, :cidade, :bairro, :telefone, :cep, :logo, :categoria_id, :user_id])
    |> validate_required([:nome, :cnpj, :endereco, :estado, :cidade, :bairro, :telefone, :cep, :logo, :categoria_id])
  end
end
