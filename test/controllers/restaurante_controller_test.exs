defmodule Tccv2.RestauranteControllerTest do
  use Tccv2.ConnCase

  alias Tccv2.Restaurante
  @valid_attrs %{cnpj: "some content", logo: "some content", nome: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, restaurante_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing restaurantes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, restaurante_path(conn, :new)
    assert html_response(conn, 200) =~ "New restaurante"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, restaurante_path(conn, :create), restaurante: @valid_attrs
    assert redirected_to(conn) == restaurante_path(conn, :index)
    assert Repo.get_by(Restaurante, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, restaurante_path(conn, :create), restaurante: @invalid_attrs
    assert html_response(conn, 200) =~ "New restaurante"
  end

  test "shows chosen resource", %{conn: conn} do
    restaurante = Repo.insert! %Restaurante{}
    conn = get conn, restaurante_path(conn, :show, restaurante)
    assert html_response(conn, 200) =~ "Show restaurante"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, restaurante_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    restaurante = Repo.insert! %Restaurante{}
    conn = get conn, restaurante_path(conn, :edit, restaurante)
    assert html_response(conn, 200) =~ "Edit restaurante"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    restaurante = Repo.insert! %Restaurante{}
    conn = put conn, restaurante_path(conn, :update, restaurante), restaurante: @valid_attrs
    assert redirected_to(conn) == restaurante_path(conn, :show, restaurante)
    assert Repo.get_by(Restaurante, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    restaurante = Repo.insert! %Restaurante{}
    conn = put conn, restaurante_path(conn, :update, restaurante), restaurante: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit restaurante"
  end

  test "deletes chosen resource", %{conn: conn} do
    restaurante = Repo.insert! %Restaurante{}
    conn = delete conn, restaurante_path(conn, :delete, restaurante)
    assert redirected_to(conn) == restaurante_path(conn, :index)
    refute Repo.get(Restaurante, restaurante.id)
  end
end
