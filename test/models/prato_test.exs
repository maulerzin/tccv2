defmodule Tccv2.PratoTest do
  use Tccv2.ModelCase

  alias Tccv2.Prato

  @valid_attrs %{nome: "some content", valor: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Prato.changeset(%Prato{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Prato.changeset(%Prato{}, @invalid_attrs)
    refute changeset.valid?
  end
end
