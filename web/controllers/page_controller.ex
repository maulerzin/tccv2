defmodule Tccv2.PageController do
  use Tccv2.Web, :controller
  

  def index(conn, _params) do
    render conn, "index.html"
  end
end
