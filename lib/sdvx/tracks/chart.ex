defmodule Sdvx.Tracks.Chart do
  import EctoEnum

  defenum Pattern, :pattern, [
    :nov,
    :adv,
    :exh,
    :mxm,
    :inf,
    :grv,
    :hvn,
    :vvd,
  ]

  use Ecto.Schema
  import Ecto.Changeset

  schema "charts" do
    field :level, :integer
    field :jacket_url, :string
    field :pattern, Pattern
    field :delete, :boolean, virtual: true

    belongs_to :song, Sdvx.Tracks.Song
    timestamps()
  end

  def changeset(chart, attrs) do
    chart
    |> cast(attrs, [:level, :jacket_url, :pattern], [:delete])
    |> validate_required([:level, :jacket_url, :pattern])
    |> validate_number(:level, greater_than: 0, less_than_or_equal_to: 20)
    |> mark_delete()
  end

  def mark_delete(changeset) do
    IO.inspect(changeset)
    if get_change(changeset, :delete) do
      %{ changeset | action: :delete }
    else
      changeset
    end
  end
end
