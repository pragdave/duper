defmodule Config do

  @name :duper_config

  @moduledoc """
  Store app config in an agent.
  """

  def start_link do
    Agent.start_link(fn -> Application.get_env(:duper, :config) end, name: @name)
  end

  def path(to) do
    Agent.get(@name, &(&1[:paths][to]))
  end
end
