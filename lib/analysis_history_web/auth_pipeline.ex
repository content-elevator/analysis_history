defmodule AnalysisHistory.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :AnalysisHistory,
                              module: AnalysisHistory.Guardian,
                              error_handler: AnalysisHistory.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
#  plug Guardian.Plug.LoadResource

end
