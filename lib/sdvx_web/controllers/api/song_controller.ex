defmodule SdvxWeb.Api.SongController do
  use SdvxWeb, :controller
  alias Sdvx.Tracks.Chart

  @fields [:id, :pattern, :level, :jacket_url, :chart_url]

  def get(conn, _params) do
    songs = Sdvx.Api.get_songs()
    |> Enum.group_by(&(&1.song_id))
    |> Enum.map(&format_song/1)

    json conn, songs
  end

  defp format_song({song_id, charts}) do
    first = Enum.at(charts, 0)

    %{
      id: song_id,
      artist: first.song.artist,
      title: first.song.title,
      charts: Enum.map(charts, &format_chart/1),
    }
  end

  defp format_chart(%Chart{} = chart) do
    Map.take(chart, @fields)
  end
end
