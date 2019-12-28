defmodule SdvxWeb.ChartControllerTest do
  use SdvxWeb.ConnCase

  alias Sdvx.Tracks

  @create_attrs %{jacket_url: "some jacket_url", level: 42, pattern: "some pattern"}
  @update_attrs %{jacket_url: "some updated jacket_url", level: 43, pattern: "some updated pattern"}
  @invalid_attrs %{jacket_url: nil, level: nil, pattern: nil}

  def fixture(:chart) do
    {:ok, chart} = Tracks.create_chart(@create_attrs)
    chart
  end

  describe "index" do
    test "lists all charts", %{conn: conn} do
      conn = get(conn, Routes.chart_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Charts"
    end
  end

  describe "new chart" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.chart_path(conn, :new))
      assert html_response(conn, 200) =~ "New Chart"
    end
  end

  describe "create chart" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.chart_path(conn, :create), chart: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.chart_path(conn, :show, id)

      conn = get(conn, Routes.chart_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Chart"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.chart_path(conn, :create), chart: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Chart"
    end
  end

  describe "edit chart" do
    setup [:create_chart]

    test "renders form for editing chosen chart", %{conn: conn, chart: chart} do
      conn = get(conn, Routes.chart_path(conn, :edit, chart))
      assert html_response(conn, 200) =~ "Edit Chart"
    end
  end

  describe "update chart" do
    setup [:create_chart]

    test "redirects when data is valid", %{conn: conn, chart: chart} do
      conn = put(conn, Routes.chart_path(conn, :update, chart), chart: @update_attrs)
      assert redirected_to(conn) == Routes.chart_path(conn, :show, chart)

      conn = get(conn, Routes.chart_path(conn, :show, chart))
      assert html_response(conn, 200) =~ "some updated jacket_url"
    end

    test "renders errors when data is invalid", %{conn: conn, chart: chart} do
      conn = put(conn, Routes.chart_path(conn, :update, chart), chart: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Chart"
    end
  end

  describe "delete chart" do
    setup [:create_chart]

    test "deletes chosen chart", %{conn: conn, chart: chart} do
      conn = delete(conn, Routes.chart_path(conn, :delete, chart))
      assert redirected_to(conn) == Routes.chart_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.chart_path(conn, :show, chart))
      end
    end
  end

  defp create_chart(_) do
    chart = fixture(:chart)
    {:ok, chart: chart}
  end
end
