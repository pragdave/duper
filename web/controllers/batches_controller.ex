defmodule Duper.BatchesController do
  use Phoenix.Controller
  import Duper.Controllers.Helpers, only: [ redirect_with_flash: 4]

  def batch_rerun(conn, %{ "id" => id }) do
    batch = Repo.get(Batch, String.to_integer(id))
    Batch.rerun(batch, Repo)
    redirect_with_flash(conn, "/", :success, "'#{batch.base_folder}' updated")
  end


end
