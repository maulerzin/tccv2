

defmodule Tccv2.PratoController do
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

  def create(conn, %{"restaurante" => prato_params}) do
    prato_params =
    prato_params
    |> Map.put("user_id", conn.assigns.current_user.id)

  changeset = Restaurante.changeset(%Restaurante{}, prato_params)

  case Repo.insert(changeset) do
    {:ok, _prato} ->
      conn
      |> put_flash(:info, "Restaurante Adicionado")
      |> redirect(to: prato_path(conn, :index))
    {:error, changeset} ->
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    restaurante = Repo.get!(Restaurante, id)
    render(conn, "show.html", restaurante: restaurante)
  end

  def edit(conn, %{"id" => id}) do
    restaurante = Repo.get!(Restaurante, id)
    changeset = Restaurante.changeset(restaurante)
    render(conn, "edit.html", restaurante: restaurante, changeset: changeset)
  end

  def update(conn, %{"id" => id, "restaurante" => prato_params}) do
    restaurante = Repo.get!(Restaurante, id)
    changeset = Restaurante.changeset(restaurante, prato_params)

    case Repo.update(changeset) do
      {:ok, restaurante} ->
        conn
        |> put_flash(:info, "Restaurante updated successfully.")
        |> redirect(to: prato_path(conn, :show, restaurante))
      {:error, changeset} ->
        render(conn, "edit.html", restaurante: restaurante, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurante = Repo.get!(Restaurante, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(restaurante)

    conn
    |> put_flash(:info, "Restaurante deleted successfully.")
    |> redirect(to: prato_path(conn, :index))
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
