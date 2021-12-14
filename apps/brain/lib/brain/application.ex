defmodule Brain.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Brain.Supervisor.start_link(name: Brain.Supervisor)
  end
end
