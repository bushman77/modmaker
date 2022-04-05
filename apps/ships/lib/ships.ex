defmodule Ships do
  use GenServer
  @moduledoc """
  Documentation for `Ships`.
  """


  def start_link(_), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
    @impl true
    def init(:ok) do
      {:ok, %{ location: "mods/STA3_UPRISING/Gameinfo/" 
            } 
      }
  end

  @doc """
  Ships.all/1 returns a list of ships for a given shiptype
  """
  def all(shiptype) , do: GenServer.call(__MODULE__, {:listships, shiptype})
    @impl true
    def handle_call({:listships, shiptype}, _from, state) do
      {:ok, directory} = File.ls(state.location)
      ships = Enum.reduce(directory, [] , fn file, acc -> 
        contents = 
            Enum.join([state.location,file])
            |>File.read()
            |>CoreFunctions.file_to_list

          case contents|>Enum.at(2) do
            {"entitytype", ["Titan"], 0} -> 
              acc ++ 
                [convert_object(contents)
                |>Map.drop([:object, :element, :nested, :nested_deep])
                |>Map.put_new(:file, file)
                ]
            _ -> acc
          end
      end)

      {:reply,
        ships,
        state
      }
  end

  def one(file \\ "B_Titan_Progenitor.entity"), do: GenServer.call(__MODULE__, {:oneship, file})
    @impl true
    def handle_call({:oneship, file}, _from, state) do
    #file = "B_Titan_Progenitor.entity"
      contents = 
        File.read(Enum.join([state.location, file]))
        |>CoreFunctions.file_to_list
        |> convert_object()
        |>Map.drop([:object, :element, :nested, :nested_deep])
        |>Map.put_new(:file, file)
   {:reply, contents, state}
#      
#    
  end

  defp convert_object(ship) do
    converted = Enum.reduce(ship, shipObj(), fn line, map -> 
      [line, map.element]
      |>case do
        ## if we encouner an empty key or txt2 just ignore
        [{"", [], 0}, ""] -> map
        [{"txt2", [], 0}, ""] -> map

        [{"numweapons", [val], 0}, element] -> 
          %{map|> Map.put_new(:numweapons, val)
               |> Map.put_new(:weapons, [])
            | element: :weapons, nested: ""
          }

        [{"weapon", [], 0}, :weapons] ->
          map.object|>Map.keys 
          |>case do
            [] ->  map
            _ ->
              %{map|weapons: map[:weapons]++[map.object],
                object: %{}
              }
          end

        [{key, [val], 0}, :weapons] ->
          ## need to insert the last weapon into the weapons array
          ## 
          ## clear out the object back to an empty state
          ## then need to add the regular object to its proper loc
          map


        [{key, [val], 1}, :weapons] -> put_in(map[:object][string_to_atom(key)], val)

        [{key, [], 1}, :weapons] ->
          key = String.replace(key, "\t","")
          update = %{map| nested: key}
          put_in(update[:object][String.replace(key, "\t","")], %{})

        [{key, [], 2}, :weapons] ->
          put_in(map[:object]["weaponeffects"][String.replace(key,"\t","")], %{})

        [{key, [val], 2}, :weapons] ->
          key = String.replace(key, "\t","")
          put_in(map[:object][map.nested][key], val)

        [{key, [val], 3}, :weapons] -> map
          #IO.inspect line
          #put_in(map[:object]["weaponeffects"]["muzzlesounds"],val)
  
        [{key, [], 0}, element] -> 
          %{map | element: string_to_atom(key)}
          |>Map.put_new(string_to_atom(key), %{})

        [{key, [val], 0}, element] -> 
          %{(map|> Map.put_new(string_to_atom(key), val)) | element: "", nested: ""}
     
        [{key, [], 1}, element] ->
          update = map
          |> Map.replace(:nested, string_to_atom(key))
          put_in(update, [element,string_to_atom(key)],%{})

        [{key, [val], 1}, element] ->
          put_in(map[element][string_to_atom(key)], val)

        [{key, [val], 2}, element] ->
          case key do
            "\t\tsoundcount" ->
              sound = put_in(map[element][map.nested][:sounds], [])
              put_in(sound[element][map.nested][string_to_atom(key)], val)

            "\t\tsound" -> 
              put_in(
                map[element][map.nested][:sounds],
                map[element][map.nested][:sounds] ++ [val]
              )

            _ ->
              put_in(map[element][map.nested][string_to_atom(key)], val)

          end
        _ -> map
      end
    end)
  end

  defp string_to_atom(key) do
    key
    |>String.replace(["\t",":"],"")
    |>String.to_atom
  end

  ## Ship Object Empty Container
  def shipObj() do
    %{element: "", nested: "", nested_deep: "", object: %{}
    }
  end
  def jason(map) do
    map
    |>Jason.encode!
  end
end
