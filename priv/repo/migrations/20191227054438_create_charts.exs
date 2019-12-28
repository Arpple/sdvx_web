defmodule Sdvx.Repo.Migrations.CreateCharts do
  use Ecto.Migration

  def change do
    create table(:charts) do
      add :level, :integer
      add :jacket_url, :string
      add :pattern, :string
      add :song_id, references(:songs)

      timestamps()
    end

  end
end
