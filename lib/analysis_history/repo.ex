defmodule AnalysisHistory.Repo do
  use Ecto.Repo,
    otp_app: :analysis_history,
    adapter: Ecto.Adapters.Postgres
end
