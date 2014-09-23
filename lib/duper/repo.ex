defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  require Logger

  def log({:query, sql}, fun) do
    {time, result} = :timer.tc(fun)
    Logger.info("#{sql} took #{time/1000}mS")
    result
  end

  def log(other, fun) do
    Logger.info(inspect(other))
    fun.()
  end

  def conf do
    parse_url "ecto://dave@localhost/dave"
  end

  def priv do
    app_dir(:duper, "priv/repo")
  end
end
