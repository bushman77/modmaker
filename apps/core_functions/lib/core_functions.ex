defmodule CoreFunctions do
  @moduledoc """
  Documentation for `CoreFunctions`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CoreFunctions.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  function file_to_list/1
  takes a string and file location, with single quotes
  """
  def file_to_list({:ok, file}) do
         (file|>String.split("\r\n"))
         |> Enum.reduce( [], fn line, acc -> 
           split = line
             |>String.replace(["\""],"")
             |>String.split(" ")
           [h|t] = split
           acc++[
             {h|>String.downcase(),
              t,
              h|>tabs
             }
           ]
        end)
  end

  def list_to_map(list) do
    list
  end
  
  def put_new(map, key, val) do
    Map.put_new(map, key, val)
  end
   
  ## DEFAULT VALUES FOR TYPES OF DATA
  def tabs(str) do
    str|>String.graphemes|>Enum.count(& &1 == "\t")
  end

end
