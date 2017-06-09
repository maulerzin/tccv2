defmodule Tccv2.PratoControllerTest do
  use Tccv2.ConnCase

  alias Tccv2.Prato
  @valid_attrs %{nome: "some content", valor: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, prato_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing pratos"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, prato_path(conn, :new)
    assert html_response(conn, 200) =~ "New prato"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, prato_path(conn, :create), prato: @valid_attrs
    assert redirected_to(conn) == prato_path(conn, :index)
    assert Repo.get_by(Prato, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, prato_path(conn, :create), prato: @invalid_attrs
    assert html_response(conn, 200) =~ "New prato"
  end

  test "shows chosen resource", %{conn: conn} do
    prato = Repo.insert! %Prato{}
    conn = get conn, prato_path(conn, :show, prato)
    assert html_response(conn, 200) =~ "Show prato"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, prato_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    prato = Repo.insert! %Prato{}
    conn = get conn, prato_path(conn, :edit, prato)
    assert html_response(conn, 200) =~ "Edit prato"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    prato = Repo.insert! %Prato{}
    conn = put conn, prato_path(conn, :update, prato), prato: @valid_attrs
    assert redirected_to(conn) == prato_path(conn, :show, prato)
    assert Repo.get_by(Prato, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    prato = Repo.insert! %Prato{}
    conn = put conn, prato_path(conn, :update, prato), prato: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit prato"
  end

  test "deletes chosen resource", %{conn: conn} do
    prato = Repo.insert! %Prato{}
    conn = delete conn, prato_path(conn, :delete, prato)
    assert redirected_to(conn) == prato_path(conn, :index)
    refute Repo.get(Prato, prato.id)
  end
end
