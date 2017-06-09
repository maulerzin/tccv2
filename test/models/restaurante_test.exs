defmodule Tccv2.RestauranteTest do
  use Tccv2.ModelCase

  alias Tccv2.Restaurante

  @valid_attrs %{cnpj: "some content", logo: "some content", nome: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Restaurante.changeset(%Restaurante{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Restaurante.changeset(%Restaurante{}, @invalid_attrs)
    refute changeset.valid?
  end
end
