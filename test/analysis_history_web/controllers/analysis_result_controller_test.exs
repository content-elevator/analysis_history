defmodule AnalysisHistoryWeb.AnalysisResultControllerTest do
  use AnalysisHistoryWeb.ConnCase

  alias AnalysisHistory.Results
  alias AnalysisHistory.Results.AnalysisResult

  @create_attrs %{
    average_length: 42,
    length: 42,
    query: "some query",
    score: 42,
    url: "some url",
    user_id: 42
  }
  @update_attrs %{
    average_length: 43,
    length: 43,
    query: "some updated query",
    score: 43,
    url: "some updated url",
    user_id: 43
  }
  @invalid_attrs %{average_length: nil, length: nil, query: nil, score: nil, url: nil, user_id: nil}

  def fixture(:analysis_result) do
    {:ok, analysis_result} = Results.create_analysis_result(@create_attrs)
    analysis_result
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all analysis_results", %{conn: conn} do
      conn = get(conn, Routes.analysis_result_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create analysis_result" do
    test "renders analysis_result when data is valid", %{conn: conn} do
      conn = post(conn, Routes.analysis_result_path(conn, :create), analysis_result: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.analysis_result_path(conn, :show, id))

      assert %{
               "id" => id,
               "average_length" => 42,
               "length" => 42,
               "query" => "some query",
               "score" => 42,
               "url" => "some url",
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.analysis_result_path(conn, :create), analysis_result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update analysis_result" do
    setup [:create_analysis_result]

    test "renders analysis_result when data is valid", %{conn: conn, analysis_result: %AnalysisResult{id: id} = analysis_result} do
      conn = put(conn, Routes.analysis_result_path(conn, :update, analysis_result), analysis_result: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.analysis_result_path(conn, :show, id))

      assert %{
               "id" => id,
               "average_length" => 43,
               "length" => 43,
               "query" => "some updated query",
               "score" => 43,
               "url" => "some updated url",
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, analysis_result: analysis_result} do
      conn = put(conn, Routes.analysis_result_path(conn, :update, analysis_result), analysis_result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete analysis_result" do
    setup [:create_analysis_result]

    test "deletes chosen analysis_result", %{conn: conn, analysis_result: analysis_result} do
      conn = delete(conn, Routes.analysis_result_path(conn, :delete, analysis_result))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.analysis_result_path(conn, :show, analysis_result))
      end
    end
  end

  defp create_analysis_result(_) do
    analysis_result = fixture(:analysis_result)
    {:ok, analysis_result: analysis_result}
  end
end
