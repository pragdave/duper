defmodule Duper.PageController do
  use Phoenix.Controller

  def index(conn, _params) do
    render conn, "index", 
           master_folder:   Config.path(:master_folder),
           batches:         Repo.all(Batch),
           repo:            Repo,
           duplicate_count: Dup.count(Repo),
           duplicates:      Dup.first_ten_signatures(Repo),
           flash:           Flash.get(conn)
  end

  def not_found(conn, _params) do
    render conn, "not_found"
  end

  def error(conn, _params) do
    render conn, "error"
  end

end
