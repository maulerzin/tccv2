defmodule Tccv2.User do
  use Tccv2.Web, :model
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    field :estado, :string
      field :cidade, :string
      field :bairro, :string
      field :cep, :string
      field :cpf, :string
      field :endereco, :string
      field :telefone, :string
    coherence_schema

    has_many :restaurantes, Tccv2.Restaurante

    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email, :estado, :cidade, :bairro, :cep, :cpf, :endereco, :telefone] ++ coherence_fields)
    |> validate_required([:name, :email, :estado, :cidade, :bairro, :cep, :cpf, :endereco, :telefone])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end
end
