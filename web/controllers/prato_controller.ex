

defmodule Tccv2.PratoController do
  use Tccv2.Web, :controller
  alias Tccv2.{User, Restaurante, Prato}

  plug PolicyWonk.LoadResource, [:restaurante] when action in [:index, :show, :edit, :update, :delete]
  plug PolicyWonk.Enforce, :restaurante_owner when action in [:index, :show, :edit, :update, :delete]

  def index(conn, %{"restaurante_id" => restaurante_id}) do
    query = from r in Prato, where: r.restaurante_id == ^restaurante_id
    pratos = Repo.all(query)
    render(conn, "index.html", restaurante_id: restaurante_id, pratos: pratos)
  end

  def new(conn, %{"restaurante_id" => restaurante_id}) do
    changeset = Prato.changeset(%Prato{})
    render(conn, "new.html",restaurante_id: restaurante_id, changeset: changeset)
  end

  def create(conn, %{"restaurante_id" => restaurante_id, "prato" => prato_params}) do
    changeset = Prato.changeset(%Prato{}, Map.put(prato_params, "restaurante_id", restaurante_id))

    case Repo.insert(changeset) do
      {:ok, _prato} ->
        conn
        |> put_flash(:info, "Prato created successfully.")
        |> redirect(to: restaurante_prato_path(conn, :index, restaurante_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "restaurante_id" => restaurante_id}) do
    prato = Repo.get!(Prato, id)
    render(conn, "show.html", restaurante_id: restaurante_id, prato: prato)
  end

  def edit(conn, %{"id" => id, "restaurante_id" => restaurante_id}) do
    prato = Repo.get!(Prato, id)
    changeset = Prato.changeset(prato)
    render(conn, "edit.html", restaurante_id: restaurante_id, prato: prato, changeset: changeset)
  end

  def update(conn, %{"restaurante_id" => restaurante_id, "id" => id, "prato" => prato_params}) do
    prato = Repo.get!(Prato, id)
    changeset = Prato.changeset(prato, prato_params)

    case Repo.update(changeset) do
      {:ok, prato} ->
        conn
        |> put_flash(:info, "Prato updated successfully.")
        |> redirect(to: restaurante_prato_path(conn, :show, restaurante_id, prato))
      {:error, changeset} ->
        render(conn, "edit.html", prato: prato, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id,"restaurante_id" => restaurante_id}) do
    prato = Repo.get!(Prato, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(prato)

    conn
    |> put_flash(:info, "Prato deleted successfully.")
    |> redirect(to: restaurante_prato_path(conn, :index, restaurante_id))
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

    def load_resource(_conn, :restaurante, %{"restaurante_id" => id}) do
      case Repo.get(Restaurante, id) do
        nil -> :not_found
       restaurante -> {:ok, :restaurante, restaurante}
      end
    end

    def policy_error(conn, :not_found) do
      Tccv2.ErrorHandlers.resource_not_found(conn, :not_found)
    end


end
