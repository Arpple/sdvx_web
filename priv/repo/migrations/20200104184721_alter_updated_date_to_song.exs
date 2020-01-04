defmodule Sdvx.Repo.Migrations.AlterUpdatedDateToSong do
  use Ecto.Migration

  def change do
    alter table(:charts) do
      remove :updated_date
    end

    alter table(:songs) do
      add :updated_date, :date
    end
  end
end
