defmodule AnalysisHistory.Results.AnalysisResult do
  use Ecto.Schema
  import Ecto.Changeset
  import String

  schema "analysis_results" do
    field :average_length, :integer
    field :length, :integer
    field :query, :string
    field :score, :integer
    field :url, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(analysis_result, attrs) do
    analysis_result
    |> cast(attrs, [:user_id, :query, :url, :length, :average_length, :score])
    |> validate_required([:user_id, :query, :url, :length, :average_length, :score])
  end
end
