defmodule Sdvx.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :title, :string
      add :artist, :string

      timestamps()
    end

  end
end
