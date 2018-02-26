defmodule Tccv2.InicioController do
  use Tccv2.Web, :controller


  alias Tccv2.Categoria
    alias Tccv2.{Restaurante, User, Carrinho,LineItem, Prato}


    plug PolicyWonk.LoadResource, [:restaurante] when action in [:show, :edit, :update, :delete]
  plug PolicyWonk.Enforce, :restaurante_owner when action in [:show, :edit, :update, :delete]



  def index(conn, _params) do

  restaurantes = Repo.all(Restaurante)
  render(conn, "index.html", restaurantes: restaurantes)
  end


  def japones(conn, _params) do

    japones = "1"
    query = from r in Restaurante,
          where: r.categoria_id == ^japones
  restaurantes = Repo.all(query)
  render(conn, "index.html", restaurantes: restaurantes)
  end

  def pizza(conn, _params) do


    query = from r in Restaurante,
          where: r.categoria_id == "2"
  restaurantes = Repo.all(query)
  render(conn, "index.html", restaurantes: restaurantes)
  end

end
