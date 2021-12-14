defmodule Database do
  use GenServer
  @moduledoc """
  Documentation for `Database`.
  """


  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: Database)
  end
  @impl true
  def init(:ok) do
    # Schedule work to be performed on start
    {:ok, []}
  end

  def build_user_table() do
    :mnesia.create_table(:users, 
      [ disc_copies: [node()],
        record_name: Frontend.Users.User,
        attributes: [:id, :email, :password_hash, :inserted_at, :updated_at],
        type: :ordered_set
      ]
    )
  end

  def delete_user_table() do
    :mnesia.delete_table(:users)
  end
end
