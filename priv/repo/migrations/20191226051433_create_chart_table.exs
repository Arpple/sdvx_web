defmodule Sdvx.Repo.Migrations.CreateChartTable do
  use Ecto.Migration
  alias Sdvx.Tracks.Chart

  def change do
    create table(:charts) do
      add :song_id, references("songs")
      add :level, :integer
      add :jacket_url, :string
      add :pattern, :string

      timestamps()
    end
  end
end
