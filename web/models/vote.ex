defmodule RateMyBeard.Vote do
  use RateMyBeard.Web, :model

  schema "votes" do
    field :ip_address, :string

    belongs_to :entry, RateMyBeard.Entry

    timestamps
  end

  @required_fields ~w(ip_address)a
  @optional_fields ~w(entry_id)a

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(@required_fields, @optional_fields)
  end

  def create_changeset(ip, entry_id) do
    %RateMyBeard.Vote{}
    |> changeset(%{ip_address: ip, entry_id: entry_id})
  end
end
