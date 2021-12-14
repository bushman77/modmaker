defmodule Brain do
  use GenServer
  @moduledoc """
  Documentation for `Brain`.
  """

  def start_link(_), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
    @impl true
    def init(:ok) do
      {:ok, 
       %{mods: 
          "/home/default/modmaker_umbrella/mods/",
       }
      }
  end

  def system do
      GenServer.call(__MODULE__, {:system} )
    end
    @impl true
    def handle_call({:system}, _from, state) do
      {:reply, state, state}
  end
  
  @doc """
  Hello world.

  ## Examples

      iex> Brain.hello()
      :world

  """
  def hello do
    :world
  end
end
