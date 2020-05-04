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
    |> cast(attrs, [:query, :url, :length, :average_length, :score])
    |> validate_required([:query, :url, :length, :average_length, :score])
  end

  def save_analysis_changeset(analysis_result, attrs, user_id) do
    analysis_result
    |> changeset(attrs)
    |> cast(user_id, [:user_id])
    |> validate_required([:user_id])
  end
end
