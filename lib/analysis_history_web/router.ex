defmodule AnalysisHistoryWeb.Router do
  use AnalysisHistoryWeb, :router
  alias AnalysisHistory.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/history/v1", AnalysisHistoryWeb do
    pipe_through [:api]
    post "/save", AnalysisResultController, :create
  end

  scope "/history/v1", AnalysisHistoryWeb do
    pipe_through [:api, :jwt_authenticated]
    get "/", AnalysisResultController, :show
  end
end
