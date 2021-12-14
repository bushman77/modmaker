defmodule FancyHeader do
  use Surface.Component, slot: "header"

  slot default, required: true

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <#slot name="default" />
    <span> 😉 </span>
    """
  end
end
defmodule FrontendWeb.PageLive do

  use Surface.LiveView

  alias FrontendWeb.Components.Screen

  def render(assigns) do
    ~F"""
      <FancyHeader>
        A fancy card component!
      </FancyHeader>

      <Screen />
    """
  end
end
