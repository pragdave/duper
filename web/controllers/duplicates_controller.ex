defmodule Duper.DuplicatesController do
  use Phoenix.Controller
  import Duper.Controllers.Helpers, only: [ redirect_with_flash: 4]

  def create(conn, %{"folder" => folder}) do
    folder = Batch.normalize(folder)
    if Batch.exists_for_folder?(folder, Repo) do
      redirect_with_flash(conn, "/", :danger, "You've already scanned '#{folder}'")
    else
      Batch.run(folder, Repo)
      redirect_with_flash(conn, "/", :success, "'#{folder}' added")
    end
  end
end
