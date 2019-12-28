defmodule Sdvx.TracksTest do
  use Sdvx.DataCase

  alias Sdvx.Tracks

  describe "songs" do
    alias Sdvx.Tracks.Song

    @valid_attrs %{artist: "some artist", title: "some title"}
    @update_attrs %{artist: "some updated artist", title: "some updated title"}
    @invalid_attrs %{artist: nil, title: nil}

    def song_fixture(attrs \\ %{}) do
      {:ok, song} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracks.create_song()

      song
    end

    test "list_songs/0 returns all songs" do
      song = song_fixture()
      assert Tracks.list_songs() == [song]
    end

    test "get_song!/1 returns the song with given id" do
      song = song_fixture()
      assert Tracks.get_song!(song.id) == song
    end

    test "create_song/1 with valid data creates a song" do
      assert {:ok, %Song{} = song} = Tracks.create_song(@valid_attrs)
      assert song.artist == "some artist"
      assert song.title == "some title"
    end

    test "create_song/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracks.create_song(@invalid_attrs)
    end

    test "update_song/2 with valid data updates the song" do
      song = song_fixture()
      assert {:ok, %Song{} = song} = Tracks.update_song(song, @update_attrs)
      assert song.artist == "some updated artist"
      assert song.title == "some updated title"
    end

    test "update_song/2 with invalid data returns error changeset" do
      song = song_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracks.update_song(song, @invalid_attrs)
      assert song == Tracks.get_song!(song.id)
    end

    test "delete_song/1 deletes the song" do
      song = song_fixture()
      assert {:ok, %Song{}} = Tracks.delete_song(song)
      assert_raise Ecto.NoResultsError, fn -> Tracks.get_song!(song.id) end
    end

    test "change_song/1 returns a song changeset" do
      song = song_fixture()
      assert %Ecto.Changeset{} = Tracks.change_song(song)
    end
  end

  describe "charts" do
    alias Sdvx.Tracks.Chart

    @valid_attrs %{jacket_url: "some jacket_url", level: 42, pattern: "some pattern"}
    @update_attrs %{jacket_url: "some updated jacket_url", level: 43, pattern: "some updated pattern"}
    @invalid_attrs %{jacket_url: nil, level: nil, pattern: nil}

    def chart_fixture(attrs \\ %{}) do
      {:ok, chart} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracks.create_chart()

      chart
    end

    test "list_charts/0 returns all charts" do
      chart = chart_fixture()
      assert Tracks.list_charts() == [chart]
    end

    test "get_chart!/1 returns the chart with given id" do
      chart = chart_fixture()
      assert Tracks.get_chart!(chart.id) == chart
    end

    test "create_chart/1 with valid data creates a chart" do
      assert {:ok, %Chart{} = chart} = Tracks.create_chart(@valid_attrs)
      assert chart.jacket_url == "some jacket_url"
      assert chart.level == 42
      assert chart.pattern == "some pattern"
    end

    test "create_chart/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracks.create_chart(@invalid_attrs)
    end

    test "update_chart/2 with valid data updates the chart" do
      chart = chart_fixture()
      assert {:ok, %Chart{} = chart} = Tracks.update_chart(chart, @update_attrs)
      assert chart.jacket_url == "some updated jacket_url"
      assert chart.level == 43
      assert chart.pattern == "some updated pattern"
    end

    test "update_chart/2 with invalid data returns error changeset" do
      chart = chart_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracks.update_chart(chart, @invalid_attrs)
      assert chart == Tracks.get_chart!(chart.id)
    end

    test "delete_chart/1 deletes the chart" do
      chart = chart_fixture()
      assert {:ok, %Chart{}} = Tracks.delete_chart(chart)
      assert_raise Ecto.NoResultsError, fn -> Tracks.get_chart!(chart.id) end
    end

    test "change_chart/1 returns a chart changeset" do
      chart = chart_fixture()
      assert %Ecto.Changeset{} = Tracks.change_chart(chart)
    end
  end
end
