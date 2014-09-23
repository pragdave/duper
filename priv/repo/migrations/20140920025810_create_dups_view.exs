defmodule Repo.Migrations.CreateDupsView do
  use Ecto.Migration

  def up do
    """
    create or replace view dups as 
       select signature from signatures 
       group by signature
       having count(*) > 1
    """
  end

  def down do
    "drop view dups"
  end
end
