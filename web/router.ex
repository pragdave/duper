defmodule Duper.Router do
  use Phoenix.Router

  get  "/", Duper.PageController, :index, as: :pages

  post "/", Duper.DuplicatesController, :create, as: :create

  get  "/batches/rerun/:id", Duper.BatchesController, :batch_rerun, as: :batch_rerun
end
