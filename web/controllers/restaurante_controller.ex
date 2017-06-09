defmodule Tccv2.RestauranteController do
  use Tccv2.Web, :controller


  alias Tccv2.Prato


  def index(conn, _params) do
    pratos = Repo.all(Prato)
    render(conn, "index.html", pratos: pratos)
  end

  def new(conn, _params) do
    changeset = Prato.changeset(%Prato{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"prato" => restaurante_params}) do
    changeset = Prato.changeset(%Prato{}, restaurante_params)

    case Repo.insert(changeset) do
      {:ok, _restaurante} ->
        conn
        |> put_flash(:info, "Prato created successfully.")
        |> redirect(to: restaurante_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    prato = Repo.get!(Prato, id)
    render(conn, "show.html", prato: prato)
  end

  def edit(conn, %{"id" => id}) do
    prato = Repo.get!(Prato, id)
    changeset = Prato.changeset(prato)
    render(conn, "edit.html", prato: prato, changeset: changeset)
  end

  def update(conn, %{"id" => id, "prato" => restaurante_params}) do
    prato = Repo.get!(Prato, id)
    changeset = Prato.changeset(prato, restaurante_params)

    case Repo.update(changeset) do
      {:ok, prato} ->
        conn
        |> put_flash(:info, "Prato updated successfully.")
        |> redirect(to: restaurante_path(conn, :show, prato))
      {:error, changeset} ->
        render(conn, "edit.html", prato: prato, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    prato = Repo.get!(Prato, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(prato)

    conn
    |> put_flash(:info, "Prato deleted successfully.")
    |> redirect(to: restaurante_path(conn, :index))
  end

end
