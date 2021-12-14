defmodule Modmaker.English do
  use GenServer
  @moduledoc """
  Modmaker keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  It also act as a template for other genserver mods
  """
 
  def start_link(default) do
    GenServer.start_link(__MODULE__, :ok, default)
  end

  @impl true
  def init(:ok) do
    :ets.new(:english, [:named_table, :bag])
    :dets.open_file(:file_table, [{:file, 'English.str.db'}])
    {:ok, "assets/mod/source/STA3_UPRISING/String/English.str"}
  end

  def init_db do
    GenServer.cast(__MODULE__, {:load})
  end
  @impl true
  def handle_cast({:load}, file) do
    {:ok, contents}=(file)|>File.read
    list = contents
      |>file_to_list
      |>Enum.reduce(stringObj(), fn line, map ->
        [k|v] = if length(line)!=0, do: line, else: line++[""]
        cond do
          k =="TXT2" -> 
             :ets.insert(:english, {:filetype, k})
             map
          k == "StringInfo" -> %{map|id: "", val: ""}
          k == "ID" -> %{map|id: v|>Enum.at(0)}
          k == "Value" -> 
             :ets.insert(:english, {String.to_atom(map.id), Enum.join(v, " ")})
             %{map|list: map.list++[%{id: map.id, val: Enum.join(v, " ")}]}
          true -> map
        end
      end)

    :ets.to_dets(:english, :file_table)

    IO.inspect "English.str loaded to memory"
    ## to access a key from the table:
    ## :ets.match_object(:english, {:"IDSICOLobbyScreenJoinGameButton", :_})
    {:noreply, file}
  end

  def stringObj do
    %{id: "", val: "", list: []}
  end

  def get(key) do
    :dets.match_object(:file_table, {String.to_atom(key), :_})
    |>Enum.at(0)
    |>elem(1)
  end

  def file_to_list(file) do
      Enum.reduce(file|>String.split("\r\n"), [], fn line, acc -> 
        acc++[
          line
            |>String.replace(["\t","\""],"")
            |>String.split(~r/\W/, trim: true)
        ]
      end)
  end
end
