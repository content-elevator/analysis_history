#defmodule AnalysisHistory.ResultsTest do
#  use AnalysisHistory.DataCase
#
#  alias AnalysisHistory.Results
#
#  describe "analysis_results" do
#    alias AnalysisHistory.Results.AnalysisResult
#
#    @valid_attrs %{average_length: 42, length: 42, query: "some query", score: 42, url: "some url", user_id: 42}
#    @update_attrs %{average_length: 43, length: 43, query: "some updated query", score: 43, url: "some updated url", user_id: 43}
#    @invalid_attrs %{average_length: nil, length: nil, query: nil, score: nil, url: nil, user_id: nil}
#
#    def analysis_result_fixture(attrs \\ %{}) do
#      {:ok, analysis_result} =
#        attrs
#        |> Enum.into(@valid_attrs)
#        |> Results.create_analysis_result()
#
#      analysis_result
#    end
#
#    test "list_analysis_results/0 returns all analysis_results" do
#      analysis_result = analysis_result_fixture()
#      assert Results.list_analysis_results() == [analysis_result]
#    end
#
#    test "get_analysis_result!/1 returns the analysis_result with given id" do
#      analysis_result = analysis_result_fixture()
#      assert Results.get_analysis_result!(analysis_result.id) == analysis_result
#    end
#
#    test "create_analysis_result/1 with valid data creates a analysis_result" do
#      assert {:ok, %AnalysisResult{} = analysis_result} = Results.create_analysis_result(@valid_attrs)
#      assert analysis_result.average_length == 42
#      assert analysis_result.length == 42
#      assert analysis_result.query == "some query"
#      assert analysis_result.score == 42
#      assert analysis_result.url == "some url"
#      assert analysis_result.user_id == 42
#    end
#
#    test "create_analysis_result/1 with invalid data returns error changeset" do
#      assert {:error, %Ecto.Changeset{}} = Results.create_analysis_result(@invalid_attrs)
#    end
#
#    test "update_analysis_result/2 with valid data updates the analysis_result" do
#      analysis_result = analysis_result_fixture()
#      assert {:ok, %AnalysisResult{} = analysis_result} = Results.update_analysis_result(analysis_result, @update_attrs)
#      assert analysis_result.average_length == 43
#      assert analysis_result.length == 43
#      assert analysis_result.query == "some updated query"
#      assert analysis_result.score == 43
#      assert analysis_result.url == "some updated url"
#      assert analysis_result.user_id == 43
#    end
#
#    test "update_analysis_result/2 with invalid data returns error changeset" do
#      analysis_result = analysis_result_fixture()
#      assert {:error, %Ecto.Changeset{}} = Results.update_analysis_result(analysis_result, @invalid_attrs)
#      assert analysis_result == Results.get_analysis_result!(analysis_result.id)
#    end
#
#    test "delete_analysis_result/1 deletes the analysis_result" do
#      analysis_result = analysis_result_fixture()
#      assert {:ok, %AnalysisResult{}} = Results.delete_analysis_result(analysis_result)
#      assert_raise Ecto.NoResultsError, fn -> Results.get_analysis_result!(analysis_result.id) end
#    end
#
#    test "change_analysis_result/1 returns a analysis_result changeset" do
#      analysis_result = analysis_result_fixture()
#      assert %Ecto.Changeset{} = Results.change_analysis_result(analysis_result)
#    end
#  end
#end
