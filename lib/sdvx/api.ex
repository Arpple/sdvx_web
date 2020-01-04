defmodule Sdvx.Api do
  import Ecto.Query

  alias Sdvx.Repo
  alias Sdvx.Tracks.Chart
  alias Sdvx.Tracks.Song

  def get_songs() do
    query = from c in Chart,
      join: s in Song, on: c.song_id == s.id,
      group_by: [c.song_id, c.id, s.updated_date],
      order_by: [desc: s.updated_date, asc: c.level],
      preload: [:song]

    Repo.all(query)
  end
end
