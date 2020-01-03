defmodule Sdvx.Api do
  import Ecto.Query

  alias Sdvx.Repo
  alias Sdvx.Tracks.Chart

  def get_songs() do
    query = from c in Chart,
      group_by: [c.song_id, c.id],
      order_by: [desc: c.updated_date, asc: c.level],
      preload: [:song]

    Repo.all(query)
  end
end
