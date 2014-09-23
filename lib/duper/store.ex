defmodule Store do

  require Logger

  def add_signature(path, signature, batch) do
    Logger.info inspect(batch)
    row = %Signature{path: path, signature: signature, batch_id: batch.id}
    Logger.info inspect(row)
    try do
      Repo.insert(row)
    rescue e ->
      Logger.error(inspect(e))
    end
  end

end
