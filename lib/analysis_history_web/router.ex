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
    pipe_through [:api, :jwt_authenticated]

    post "/save", AnalysisResultController, :create
    get "/", AnalysisResultController, :show
  end
end
