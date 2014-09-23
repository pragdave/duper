defmodule Repo.Migrations.CreateSignatures do
  use Ecto.Migration

  def up do
    """
    CREATE TABLE IF NOT EXISTS signatures(
        path      varchar(256) primary key, 
        batch_id  integer      references batches(id) on delete cascade not null,
        signature bytea        not null
    )
    """
  end

  def down do
    "drop table signatures"
  end
end
