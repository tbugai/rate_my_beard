defmodule RateMyBeard.User do
  use RateMyBeard.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @allowed_params ~w(name email password password_confirmation)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @allowed_params)
  end
end
