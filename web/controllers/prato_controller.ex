

defmodule Tccv2.PratoController do
  use Tccv2.Web, :controller


  alias Tccv2.Restaurante

  def index(conn, _params) do
    restaurantes = Repo.all(Restaurante)
    render(conn, "index.html", restaurantes: restaurantes)
  end

  def new(conn, _params) do
    changeset = Restaurante.changeset(%Restaurante{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"restaurante" => prato_params}) do
    changeset = Restaurante.changeset(%Restaurante{}, prato_params)

    case Repo.insert(changeset) do
      {:ok, _prato} ->
        conn
        |> put_flash(:info, "Restaurante created successfully.")
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



end
