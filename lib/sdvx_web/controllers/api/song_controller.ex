defmodule SdvxWeb.Api.SongController do
  use SdvxWeb, :controller
  alias Sdvx.Tracks.Chart

  @fields [:id, :pattern, :level, :jacket_url, :chart_url]

  def get(conn, _params) do
    songs = Sdvx.Api.get_songs()
    |> Enum.group_by(&(&1.song_id))
    |> Enum.map(&format_song/1)
    |> Enum.sort(&sort_update/2)

    json conn, songs
  end

  defp format_song({song_id, charts}) do
    first = Enum.at(charts, 0)

    %{
      id: song_id,
      artist: first.song.artist,
      title: first.song.title,
      charts: Enum.map(charts, &format_chart/1),
      updated_date: first.song.updated_date
    }
  end

  defp format_chart(%Chart{} = chart) do
    Map.take(chart, @fields)
  end

  defp sort_update(song1, song2) do
    Date.compare(song1.updated_date, song2.updated_date) == :gt
  end
end
