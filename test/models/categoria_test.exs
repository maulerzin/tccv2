defmodule Tccv2.CategoriaTest do
  use Tccv2.ModelCase

  alias Tccv2.Categoria

  @valid_attrs %{nome: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Categoria.changeset(%Categoria{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Categoria.changeset(%Categoria{}, @invalid_attrs)
    refute changeset.valid?
  end
end
