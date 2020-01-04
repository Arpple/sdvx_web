defmodule Sdvx.Tracks.Song do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sdvx.Tracks.Chart

  schema "songs" do
    field :artist, :string
    field :title, :string
    field :updated_date, :date
    has_many :charts, Chart

    timestamps()
  end

  @doc false
  def changeset(song, attrs) do
    song
    |> cast(attrs, [:title, :artist, :updated_date])
    |> validate_required([:title, :artist, :updated_date])
  end
end
