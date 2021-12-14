defmodule FrontendWeb.Components.Screen do
  @moduledoc """
  A sample component generated by `mix surface.init`.
  """
  use Surface.Component

  import FrontendWeb.Gettext
  alias FrontendWeb.Components.Titlebar
  alias FrontendWeb.Components.Display
  #@doc "The name"
  #prop name, :string, default: "Guest"

  #@doc "The subtitle"
  #prop subtitle, :string

  #@doc "The color"
  #prop color, :string, values!: ["danger", "info", "warning"]

  def render(assigns) do
    ~F"""
    <div class="screen">
      <Titlebar></Titlebar>
     <Display></Display>
    </div>
    """
  end
end