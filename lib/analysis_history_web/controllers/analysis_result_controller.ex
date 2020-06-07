defmodule AnalysisHistoryWeb.AnalysisResultController do
  use AnalysisHistoryWeb, :controller
  require Logger

  alias AnalysisHistory.Results
  alias AnalysisHistory.Results.AnalysisResult

  action_fallback AnalysisHistoryWeb.FallbackController

  def index(conn, _params) do
    analysis_results = Results.list_analysis_results()
    render(conn, "index.json", analysis_results: analysis_results)
  end

  def create(conn, %{"analysis_result" => analysis_result_params}) do
    user_id = Guardian.Plug.current_claims(conn)["sub"]
    Logger.info "Saving new history entry for user with id: #{user_id}"
    with {:ok, %AnalysisResult{} = analysis_result} <- Results.create_analysis_result(analysis_result_params, user_id) do
      conn
      |> put_status(:created)
      |> render("analysis_result.json", analysis_result: analysis_result)
    end
  end

  def show(conn, _params) do
    user_id = Guardian.Plug.current_claims(conn)["sub"]
    Logger.info "Returning history for user with id: #{user_id}"
    analysis_results = Results.list_all_for_user_id(user_id)
    render(conn, "index.json", analysis_results: analysis_results)
  end

  def update(conn, %{"id" => id, "analysis_result" => analysis_result_params}) do
    analysis_result = Results.get_analysis_result!(id)

    with {:ok, %AnalysisResult{} = analysis_result} <- Results.update_analysis_result(analysis_result, analysis_result_params) do
      render(conn, "show.json", analysis_result: analysis_result)
    end
  end

  def delete(conn, %{"id" => id}) do
    analysis_result = Results.get_analysis_result!(id)

    with {:ok, %AnalysisResult{}} <- Results.delete_analysis_result(analysis_result) do
      send_resp(conn, :no_content, "")
    end
  end
end
