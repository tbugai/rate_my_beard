defmodule RateMyBeard.Entry do
  use RateMyBeard.Web, :model

  schema "entry" do
    field :image,       :string
    field :up_votes,    :integer
    field :down_votes,  :integer

    timestamps
  end

  @required_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
  end
end
