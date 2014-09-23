defmodule Duper.Controllers.Helpers do
  use Phoenix.Controller

  def redirect_with_flash(conn, url, level, msg) 
  when level in [ :success, :info, :level, :warning ]
  do
    conn
    |> Flash.put(level, msg)
    |> redirect(url)
  end

end
