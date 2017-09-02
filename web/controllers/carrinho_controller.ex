defmodule Tccv2.CarrinhoController do
  use Tccv2.Web, :controller

  alias Tccv2.{LineItem, Carrinho, Register}

  plug :add_cart

  def add_cart(conn, _opts) do
    carrinho = case get_session(conn, :carrinho_uuid) do
      nil ->
        Repo.insert!(%Carrinho{})
      carrinho_uuid ->
        query = from c in Carrinho, where: c.uuid == ^carrinho_uuid
        Repo.one(query)
    end

    conn |> assign(:carrinho, carrinho) |> put_session(:carrinho_uuid, carrinho.uuid)
  end

  def show(conn, _params) do
    query =
      from li in LineItem,
      where: li.carrinho_id == ^conn.assigns[:carrinho].id,
      preload: [:prato]

    line_items = Repo.all(query)

    render conn, "show.html", %{line_items: line_items}
  end

  def add(conn, %{"prato" => %{"id" => prato_id}}) do
    LineItem.changeset(%LineItem{}, %{
      prato_id: prato_id,
      carrinho_id: conn.assigns[:carrinho].id,
      quantity: 1
    }) |> Repo.insert!
    redirect conn, to: carrinho_path(conn, :show)
  end

  def checkout(conn, params) do
    Register.charge(conn.assigns[:carrinho], params["stripeToken"])
    Register.pedido(conn.assigns[:carrinho])
    redirect conn, to: carrinho_path(conn, :show)
  end
end
