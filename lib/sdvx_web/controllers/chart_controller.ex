defmodule SdvxWeb.ChartController do
  use SdvxWeb, :controller

  alias Sdvx.Tracks
  alias Sdvx.Tracks.Chart

  def index(conn, %{ "song_id" => song_id }) do
    song = Tracks.get_song!(song_id)
    charts = Tracks.list_charts(song)

    conn
    |> assign(:song, song)
    |> render("index.html", charts: charts)
  end

  def new(conn, %{ "song_id" => song_id }) do
    song = Tracks.get_song!(song_id)
    changeset = Tracks.change_chart(%Chart{})

    conn
    |> assign(:song, song)
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"chart" => chart_params, "song_id" => song_id}) do
    song = Tracks.get_song!(song_id)
    case Tracks.create_chart(song, chart_params) do
      {:ok, _chart} ->
        conn
        |> put_flash(:info, "Chart created successfully.")
        |> redirect(to: Routes.chart_path(conn, :index, song_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "song_id" => song_id}) do
    song = Tracks.get_song!(song_id)
    chart = Tracks.get_chart!(id)
    render(conn, "show.html", chart: chart, song: song)
  end

  def edit(conn, %{"id" => id, "song_id" => song_id}) do
    song = Tracks.get_song!(song_id)
    chart = Tracks.get_chart!(id)
    changeset = Tracks.change_chart(chart)
    render(conn, "edit.html", chart: chart, changeset: changeset, song: song)
  end

  def update(conn, %{"id" => id, "chart" => chart_params, "song_id" => song_id}) do
    chart = Tracks.get_chart!(id)

    case Tracks.update_chart(chart, chart_params) do
      {:ok, _chart} ->
        conn
        |> put_flash(:info, "Chart updated successfully.")
        |> redirect(to: Routes.chart_path(conn, :index, song_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        song = Tracks.get_song!(song_id)
        render(conn, "edit.html", chart: chart, song: song, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "song_id" => song_id}) do
    IO.puts("WOWWW")
    IO.inspect(id)
    song = Tracks.get_song!(song_id)
    chart = Tracks.get_chart!(id)
    {:ok, _chart} = Tracks.delete_chart(chart)

    conn
    |> put_flash(:info, "Chart deleted successfully.")
    |> assign(:song, song)
    |> redirect(to: Routes.chart_path(conn, :index, song_id))
  end
end
