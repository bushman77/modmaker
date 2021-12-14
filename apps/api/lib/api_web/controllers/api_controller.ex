defmodule ApiWeb.ApiController do
  use ApiWeb, :controller

  def api(conn, params) do
    ## check the post request for specific keys
    json(conn, 
      cond do
        Map.has_key?(params, "ships") -> 
          Ships.all()
          %{response: 200, data: []}
        True -> %{response: 404}
      end
    ) 
  end
end
