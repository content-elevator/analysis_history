defmodule AnalysisHistory.Results do
  @moduledoc """
  The Results context.
  """

  import Ecto.Query, warn: false
  alias AnalysisHistory.Repo

  alias AnalysisHistory.Results.AnalysisResult

  @doc """
  Returns the list of analysis_results.

  ## Examples

      iex> list_analysis_results()
      [%AnalysisResult{}, ...]

  """
  def list_analysis_results do
    Repo.all(AnalysisResult)
  end

  def list_all_for_user_id(user_id) do
    query = from a in AnalysisResult, where: a.user_id==^user_id
    Repo.all(query)
  end

  @doc """
  Gets a single analysis_result.

  Raises `Ecto.NoResultsError` if the Analysis result does not exist.

  ## Examples

      iex> get_analysis_result!(123)
      %AnalysisResult{}

      iex> get_analysis_result!(456)
      ** (Ecto.NoResultsError)

  """
  def get_analysis_result!(id), do: Repo.get!(AnalysisResult, id)

  @doc """
  Creates a analysis_result.

  ## Examples

      iex> create_analysis_result(%{field: value})
      {:ok, %AnalysisResult{}}

      iex> create_analysis_result(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_analysis_result(attrs \\ %{}, user_id) do
    %AnalysisResult{}
    |> AnalysisResult.save_analysis_changeset(attrs, %{"user_id" => String.to_integer(user_id)})
    |> Repo.insert()
  end

  @doc """
  Updates a analysis_result.

  ## Examples

      iex> update_analysis_result(analysis_result, %{field: new_value})
      {:ok, %AnalysisResult{}}

      iex> update_analysis_result(analysis_result, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_analysis_result(%AnalysisResult{} = analysis_result, attrs) do
    analysis_result
    |> AnalysisResult.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a analysis_result.

  ## Examples

      iex> delete_analysis_result(analysis_result)
      {:ok, %AnalysisResult{}}

      iex> delete_analysis_result(analysis_result)
      {:error, %Ecto.Changeset{}}

  """
  def delete_analysis_result(%AnalysisResult{} = analysis_result) do
    Repo.delete(analysis_result)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking analysis_result changes.

  ## Examples

      iex> change_analysis_result(analysis_result)
      %Ecto.Changeset{source: %AnalysisResult{}}

  """
  def change_analysis_result(%AnalysisResult{} = analysis_result) do
    AnalysisResult.changeset(analysis_result, %{})
  end
end
