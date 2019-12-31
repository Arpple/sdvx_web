defmodule Sdvx.Api do
  import Ecto.Query

  alias Sdvx.Repo
  alias Sdvx.Tracks.Chart

  def get_songs() do
    query = from c in Chart,
      order_by: [desc: c.updated_date],
      preload: [:song]

    Repo.all(query)
  end
end
