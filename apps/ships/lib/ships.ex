defmodule Ships do
  use GenServer
  @moduledoc """
  Documentation for `Ships`.
  """


  def start_link(_), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
    @impl true
    def init(:ok) do
      {:ok, %{ location: "" } }
  end

  @doc """
  Ships.all/1 updates the genserver with all the ships found inthe mod in json format
  """
  def all(shiptype) , do: GenServer.call(__MODULE__, {:listships, shiptype})
    @impl true
    def handle_call({:listships, shiptype}, _from, state) do
      system = Brain.system
      directory =  File.ls!(Enum.join([system.mods,"STA3_UPRISING/","Gameinfo/"]))

      ships = Enum.reduce(directory, [] , fn file, acc -> 
          contents = 
            File.read(Enum.join([system.mods,"STA3_UPRISING/","Gameinfo/",file]))
            |>CoreFunctions.file_to_list

          case contents|>Enum.at(2) do
            {"entitytype", ["Titan"], 0} -> acc ++ [convert_object(contents)]
            _ -> acc
          end
        end)

      {:reply,
        ships,
        state
      }
  end

  def one(file) do
    system = Brain.system
    file = "B_Titan_Progenitor.entity"
    contents = 
      File.read(Enum.join([system.mods, "STA3_UPRISING/", "Gameinfo/", file]))
      |>CoreFunctions.file_to_list
    convert_object(contents)
  end

  defp convert_object(ship) do
    converted = Enum.reduce(ship, shipObj(), fn line, map -> 
      case [line, map.element] do
        [{"", [], 0}, ""] -> map
        [{"txt2", [], 0}, ""] -> map

        [{"numweapons", [val], 0}, element] -> 
          %{map|> Map.put_new("numweapons", val)
               |> Map.put_new("weapons", [])
            | element: "weapons", nested: ""
          }

        [{"weapon", [], 0}, "weapons"] ->
          case map.object|>Map.keys do
            [] ->  map
            _ ->
              %{map|"weapons" => map["weapons"]++[map.object],
                object: %{}
              }
          end

        [{key, [val], 0}, "weapons"] ->
          ## need to insert the last weapon into the weapons array
          ## 
          ## clear out the object back to an empty state
          ## then need to add the regular object to its proper loc
          map


        [{key, [val], 1}, "weapons"] ->
          put_in(map[:object][String.replace(key, "\t","")], val)

        [{key, [], 1}, "weapons"] ->
          key = String.replace(key, "\t","")
          update = %{map| nested: key}
          put_in(update[:object][String.replace(key, "\t","")], %{})

        [{key, [], 2}, "weapons"] ->
          put_in(map[:object]["weaponeffects"][String.replace(key,"\t","")], %{})

        [{key, [val], 2}, "weapons"] ->
          key = String.replace(key, "\t","")
          put_in(map[:object][map.nested][key], val)

        [{key, [val], 3}, "weapons"] -> map
          #IO.inspect line
          #put_in(map[:object]["weaponeffects"]["muzzlesounds"],val)
  
        [{key, [], 0}, element] -> 
          %{map | element: key}
          |>Map.put_new(key, %{})

        [{key, [val], 0}, element] -> 
          %{(map|> Map.put_new(key, val)) | element: "", nested: ""}
     
        [{key, [], 1}, element] ->
          key = String.replace(key, "\t","")
          update = map
          |> Map.replace(:nested, String.replace(key, "\t",""))
          put_in(update, [element,key],%{})

        [{key, [val], 1}, element] ->
          put_in(map[element][String.replace(key, "\t","")], val)

        [{key, [val], 2}, element] ->
          case key do
            "\t\tsoundcount" ->
              sound = put_in(map[element][map.nested]["sounds"], [])
              put_in(sound[element][map.nested][String.replace(key, "\t","")], val)

            "\t\tsound" -> 
              put_in(
                map[element][map.nested]["sounds"],
                map[element][map.nested]["sounds"] ++ [val]
              )

            _ ->
              put_in(map[element][map.nested][String.replace(key, "\t","")], val)

          end
        _ -> map
      end
    end)
  end

  ## Ship Object Empty Container
  def shipObj() do
    %{element: "", nested: "", nested_deep: "", object: %{}
    }
  end

end
