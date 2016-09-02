defmodule RateMyBeard.Entry do
  use RateMyBeard.Web, :model
  use Arc.Ecto.Model

  schema "entry" do
    field :title,       :string
    field :image,       RateMyBeard.Image.Type
    field :up_votes,    :integer
    field :down_votes,  :integer

    has_many :votes, RateMyBeard.Vote

    timestamps
  end

  @required_fields ~w(title)
  @optional_fields ~w(up_votes down_votes)
  @required_file_fields ~w(image)

  def ordered(query) do
    query |> order_by([t], t.inserted_at)
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> cast_attachments(params, @required_file_fields, [])
  end

  def up_vote(model) do
    model
    |> cast(%{up_votes: model.up_votes + 1}, @required_fields, @optional_fields)
  end

  def down_vote(model) do
    model
    |> cast(%{down_votes: model.down_votes + 1}, @required_fields, @optional_fields)
  end
end
