defmodule Tccv2.Register do
  alias Tccv2.{Carrinho, LineItem, Pedido, Repo}
  import Ecto.Query

  @spec pedido(%Carrinho{}) :: {:ok, %Pedido{}}
  def pedido(carrinho=%Carrinho{}) do
    Repo.transaction(fn() ->
      pedido =
        Pedido.changeset(%Pedido{}, %{})
        |> Repo.insert!

      line_items =
        from li in LineItem, where: li.carrinho_id == ^carrinho.id

      {_count, _returnval} =
        line_items
        |> Repo.update_all(set: [carrinho_id: nil, pedido_id: pedido.id])

      pedido = Repo.preload(pedido, :line_items)
      pedido
    end)
  end

  @spec charge(%Carrinho{}, term()) :: {:ok, map()}
  def charge(carrinho=%Carrinho{}, token) do
    amount_in_cents = cart_amount_in_cents(carrinho)

    params = [
      source: token,
      description: "Tccv2 charge"
    ]

    Stripe.Charges.create(amount_in_cents, params)
  end

  def cart_amount(carrinho=%Carrinho{}) do
    line_items_query =
      from li in LineItem,
      join: prato in assoc(li, :prato),
      where: li.carrinho_id == ^carrinho.id,
      select: [prato.valor, li.quantity]

    line_items = Repo.all(line_items_query)

    line_items
    |> Enum.reduce(Decimal.new("0"), fn([valor, quantity], acc) ->
      quantity = Decimal.new(quantity)
      Decimal.add(acc, Decimal.mult(valor, quantity))
    end)
  end

  def cart_amount_in_cents(carrinho=%Carrinho{}) do
    amount = cart_amount(carrinho)
    amount_in_cents_d = Decimal.mult(amount, Decimal.new(100))

    {amount_in_cents, _} =
      amount_in_cents_d
      |> Decimal.to_string
      |> Integer.parse

    amount_in_cents
  end
end
