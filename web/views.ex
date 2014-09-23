defmodule Duper.Views do

  defmacro __using__(_options) do
    quote do
      use Phoenix.View
      import unquote(__MODULE__)

      # This block is expanded within all views for aliases, imports, etc
      import Duper.I18n
      import Duper.Router.Helpers
    end
  end

  # Functions defined here are available to all other views/templates

#  def flash_for(nil),  do: ""
#  def flash_for(%{}),  do: ""
  def flash_for(flash) do
    (for {level, msg} <- flash do
       wrap(:div, "alert alert-#{level}", msg)
    end)
    |> safe
  end

  def safe(list) when is_list(list), do: list |> Enum.join("\n") |> safe
  def safe(str), do: {:safe, str}

  def wrap(tag, class, content) do
    ~s{<#{tag} class="#{class}">#{content}</#{tag}>}
  end
end


