defmodule Sdvx.Repo.Migrations.CreateCharts do
  use Ecto.Migration

  def change do
    create table(:charts) do
      add :song_id, references(:songs)
      add :level, :integer
      add :jacket_url, :string
      add :pattern, :string
      add :updated_date, :date
      add :chart_url, :string
      add :youtube_url, :string

      timestamps()
    end

  end
end
