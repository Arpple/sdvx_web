defmodule Sdvx.Tracks.Song do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sdvx.Tracks.Chart

  schema "songs" do
    field :artist, :string
    field :title, :string
    has_many :charts, Chart

    timestamps()
  end

  @doc false
  def changeset(song, attrs) do
    song
    |> cast(attrs, [:title, :artist])
    |> validate_required([:title, :artist])
  end
end
