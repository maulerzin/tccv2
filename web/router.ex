defmodule Tccv2.Router do
  use Tccv2.Web, :router
   use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end
  pipeline :protected do
  plug :accepts, ["html"]
  plug :fetch_session
  plug :fetch_flash
  plug :protect_from_forgery
  plug :put_secure_browser_headers
  plug Coherence.Authentication.Session, protected: true  # Add this
end

scope "/" do
    pipe_through :browser
    coherence_routes
  end

  # Add this block
  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tccv2 do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/carrinho", CarrinhoController, :show
    post "/carrinho/add", CarrinhoController, :add, as: :add_to_cart
    post "/carrinho/checkout", CarrinhoController, :checkout, as: :checkout
    resources "/line_items", LineItemController, only: [:update, :delete]
  end
  scope "/", Tccv2 do
    pipe_through :protected
    get "/inicio", InicioController, :index
    get "/inicio/japones", InicioController, :japones
    get "/inicio/pizza", InicioController, :pizza
    get "/inicio/lanche", InicioController, :lanche
    get "/inicio/saudavel", InicioController, :saudavel
    get "/inicio/doces", InicioController, :doces
    resources "/restaurantes", RestauranteController do
    resources "/pratos", PratoController

  end

    # Add protected routes below
  end


  # Other scopes may use custom stacks.
  # scope "/api", Tccv2 do
  #   pipe_through :api
  # end
end
