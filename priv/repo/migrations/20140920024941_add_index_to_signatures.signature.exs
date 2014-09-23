defmodule :"Elixir.Repo.Migrations.AddIndexToSignatures.signature" do
  use Ecto.Migration

  def up do
    "create index i_signature on signatures using hash (signature)"
  end

  def down do
    "drop index if exists i_signature"
  end
end
