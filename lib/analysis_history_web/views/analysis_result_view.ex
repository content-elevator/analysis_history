defmodule AnalysisHistoryWeb.AnalysisResultView do
  use AnalysisHistoryWeb, :view
  alias AnalysisHistoryWeb.AnalysisResultView

  def render("index.json", %{analysis_results: analysis_results}) do
    %{data: render_many(analysis_results, AnalysisResultView, "analysis_result.json")}
  end

  def render("show.json", %{analysis_result: analysis_result}) do
    %{data: render_one(analysis_result, AnalysisResultView, "analysis_result.json")}
  end

  def render("analysis_result.json", %{analysis_result: analysis_result}) do
    %{
      id: analysis_result.id,
      user_id: analysis_result.user_id,
      query: analysis_result.query,
      url: analysis_result.url,
      length: analysis_result.length,
      average_length: analysis_result.average_length,
      score: analysis_result.score,
      created_at: analysis_result.inserted_at}
  end
end
