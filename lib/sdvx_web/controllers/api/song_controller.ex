defmodule SdvxWeb.Api.SongController do
  use SdvxWeb, :controller
  alias Sdvx.Tracks.Chart

  @fields [:id, :pattern, :level, :jacket_url, :title, :artist]

  def get(conn, _params) do
    songs = Sdvx.Api.get_songs()
    |> IO.inspect()
    |> Enum.map(&format_song/1)
    |> Enum.map(fn song -> Map.take(song, @fields) end)

    json conn, songs
  end

  defp format_song(%Chart{} = chart) do
    chart
    |> Map.put(:artist, chart.song.artist)
    |> Map.put(:title, chart.song.title)
  end
end
