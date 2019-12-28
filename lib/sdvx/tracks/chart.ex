defmodule Sdvx.Tracks.Chart do
  use Ecto.Schema
  import Ecto.Changeset

  alias Sdvx.Tracks.Song

  schema "charts" do
    field :jacket_url, :string
    field :level, :integer
    field :pattern, :string

    belongs_to :song, Song

    timestamps()
  end

  @doc false
  def changeset(chart, attrs) do
    chart
    |> cast(attrs, [:level, :jacket_url, :pattern])
    |> validate_required([:level, :jacket_url, :pattern])
  end
end
