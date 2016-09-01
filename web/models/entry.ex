defmodule RateMyBeard.Entry do
  use RateMyBeard.Web, :model
  use Arc.Ecto.Model

  schema "entry" do
    field :title,       :string
    field :image,       RateMyBeard.Image.Type
    field :up_votes,    :integer
    field :down_votes,  :integer

    timestamps
  end

  @required_fields ~w(title)
  @required_file_fields ~w(image)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> cast_attachments(params, @required_file_fields, [])
  end
end
