defmodule Tccv2.RestauranteController do
  use Tccv2.Web, :controller


  alias Tccv2.Categoria
    alias Tccv2.{Restaurante, User}

    plug :load_categories when action in [:new, :create, :edit, :update]
    plug PolicyWonk.LoadResource, [:restaurante] when action in [:show, :edit, :update, :delete]
  plug PolicyWonk.Enforce, :restaurante_owner when action in [:show, :edit, :update, :delete]

    defp load_categories(conn, _) do
      query =
        Categoria
        |> Categoria.alphabetical
        |> Categoria.names_and_ids
      categorias = Repo.all query
      assign(conn, :categorias, categorias)
    end



    def index(conn, _params) do
      query = from r in Restaurante,
            where: r.user_id == ^conn.assigns.current_user.id
    restaurantes = Repo.all(query)
    render(conn, "index.html", restaurantes: restaurantes)
    end

    def new(conn, _params) do
      changeset = Restaurante.changeset(%Restaurante{})
      render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"restaurante" => restaurante_params}) do
      restaurante_params =
      restaurante_params
      |> Map.put("user_id", conn.assigns.current_user.id)

    changeset = Restaurante.changeset(%Restaurante{}, restaurante_params)

    case Repo.insert(changeset) do
      {:ok, _restaurante} ->
        conn
        |> put_flash(:info, "Restaurante Adicionado")
        |> redirect(to: restaurante_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
      end
    end

    def show(conn=%{assigns: %{restaurante: restaurante}}, _params) do

      render(conn, "show.html", restaurante: restaurante)
    end

    def edit(conn=%{assigns: %{restaurante: restaurante}}, _params) do
      changeset = Restaurante.changeset(restaurante)
      render(conn, "edit.html", restaurante: restaurante, changeset: changeset)
    end

    def update(conn=%{assigns: %{restaurante: restaurante}}, %{"restaurante" => restaurante_params}) do
      changeset = Restaurante.changeset(restaurante, restaurante_params)

      case Repo.update(changeset) do
        {:ok, restaurante} ->
          conn
          |> put_flash(:info, "Restaurante updated successfully.")
          |> redirect(to: restaurante_path(conn, :show, restaurante))
        {:error, changeset} ->
          render(conn, "edit.html", restaurante: restaurante, changeset: changeset)
      end
    end

    def delete(conn=%{assigns: %{restaurante: restaurante}}, _params) do

      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(restaurante)

      conn
      |> put_flash(:info, "Restaurante deleted successfully.")
      |> redirect(to: restaurante_path(conn, :index))
    end

    def policy(assigns, :restaurante_owner) do
    case {assigns[:current_user], assigns[:restaurante]} do
      {%User{id: user_id}, restaurante=%Restaurante{}} ->
        case restaurante.user_id do
          ^user_id -> :ok
          _ -> :not_found
        end
      _ -> :not_found
    end
  end

  def policy_error(conn, :not_found) do
    Tccv2.ErrorHandlers.resource_not_found(conn, :not_found)
  end

  def load_resource(_conn, :restaurante, %{"id" => id}) do
    case Repo.get(Restaurante, id) do
      nil -> :not_found
      restaurante -> {:ok, :restaurante, restaurante}
    end
  end
end
