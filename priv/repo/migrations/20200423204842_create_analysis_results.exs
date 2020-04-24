defmodule AnalysisHistory.Repo.Migrations.CreateAnalysisResults do
  use Ecto.Migration

  def change do
    create table(:analysis_results) do
      add :user_id, :integer
      add :query, :string
      add :url, :string
      add :length, :integer
      add :average_length, :integer
      add :score, :integer

      timestamps()
    end

  end
end
