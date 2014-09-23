defmodule Repo.Migrations.CreateBatches do
  use Ecto.Migration

  def up do
    """
    CREATE TABLE IF NOT EXISTS batches(
        id          serial primary key, 
        base_folder varchar(256) not null
    )
    """
  end

  def down do
    "drop table batches"
  end
end
